//
//  ContactView.swift
//  Contact
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactView: View, ActionableView {

    enum Action {
        case handleAction(
            action: String,
            title: String
        )
    }

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) var dismiss
    @Binding var viewState: ContactViewState

    public init(
        viewState: Binding<ContactViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {

        VStack(spacing: 0) {
            HStack {
                CloseButton(
                    dismiss: {
                        dismiss()
                    }
                )
            }

            VStack(spacing: 60) {
                ForEach(viewState.contactRows, id: \.title) { rowData in
                    ContactRow(
                        data: rowData,
                        onAction: {
                            onAction?(
                                .handleAction(
                                    action: rowData.action,
                                    title: rowData.title
                                )
                            )
                        }
                    )
                }
            }
            .padding()
            .frame(width: 333, height: 667)
            .background(
                RadialGradient(
                    gradient: Gradient(
                        colors: [
                            Constants.Colors.neonCyan.opacity(0.03),
                            Constants.Colors.neonCyan.opacity(0.10)
                        ]
                    ),
                    center: .center,
                    startRadius: 100,
                    endRadius: 300
                )
            )
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.orange, lineWidth: 3))
            .shadow(radius: 10)
            .padding()
            .padding(.bottom, 22)
        }
        .sheet(item: $viewState.webViewURL) { webView in
            WebViewContainer(url: webView.url, title: webView.title)
        }
        Spacer()
    }
}

struct ContactRow: View {

    let data: ContactRowData
    let onAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                Text(data.title)
                    .font(.system(size: 33, design: .serif))
                    .padding(.bottom, 11)
                Image(systemName: data.icon)
                    .foregroundColor(.orange)
                    .font(.system(size: 29))
                    .padding(.leading, 5)
                    .padding(.bottom, 11)
            }
            Button(action: onAction) {
                Text(data.text)
                    .font(.system(size: 22, design: .serif))
                    .foregroundColor(.blue)
                    .underline()
            }
        }
        .multilineTextAlignment(.center)
    }
}
