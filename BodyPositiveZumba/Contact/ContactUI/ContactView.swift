//
//  ContactView.swift
//  Contact
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactView: View, ActionableView {

    enum Action {
        case handleAction(action: String, title: String)
    }

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) private var dismiss
    @Binding var viewState: ContactViewState

    public init(
        viewState: Binding<ContactViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Please Reach Out\nAnytime!")
                    .font(.sfProSerifBold(size: 35))
                    .italic()
                    .foregroundColor(.clear)
                    .multilineTextAlignment(.center)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: Constants.Colors.rainbow),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            Text("Please Reach Out\nAnytime!")
                                .font(.sfProSerifBold(size: 33))
                                .italic()
                                .multilineTextAlignment(.center)
                        )
                    )
                    .padding(.top, 25)

                VStack(spacing: 30) {
                    ForEach(viewState.contactRows, id: \.title) { row in
                        ContactRow(data: row) {
                            onAction?(.handleAction(action: row.action, title: row.title))
                        }
                    }
                }
                .padding()
                .frame(width: 340, height: 480)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 3)
                )
                .shadow(radius: 10)
                .padding()

                Spacer()
            }
            .sheet(item: $viewState.webViewURL) { webView in
                WebViewContainer(url: webView.url, title: webView.title)
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton { dismiss() }
                ToolbarButton.closeButton { dismiss() }
            }
        }
    }
}

struct ContactRow: View {
    let data: ContactRowData
    let onAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: data.icon)
                .foregroundColor(data.iconColor)
                .font(.system(size: 33))
            Button(action: onAction) {
                Text(data.text)
                    .font(.sfProRoundedTextRegular(size: 16))
                    .foregroundColor(.blue)
                    .underline()
            }
        }
        .multilineTextAlignment(.center)
    }
}
