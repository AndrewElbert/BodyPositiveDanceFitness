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
        VStack(spacing: 0) {
            HStack {
                CloseButton { dismiss() }
                Spacer()
            }

            VStack(spacing: 55) {
                ForEach(viewState.contactRows, id: \.title) { row in
                    ContactRow(data: row) {
                        onAction?(.handleAction(action: row.action, title: row.title))
                    }
                }
            }
            .padding()
            .frame(width: 333, height: 667)
            .background(
                ZStack {
                    Color.white
                    backgroundGradient
                }
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange, lineWidth: 2)
            )
            .shadow(radius: 10)
            .padding()
            .padding(.bottom, 22)

            Spacer()
        }
        .sheet(item: $viewState.webViewURL) { webView in
            WebViewContainer(url: webView.url, title: webView.title)
        }
    }

    private var backgroundGradient: RadialGradient {
        RadialGradient(
            gradient: Gradient(colors: [
                Constants.Contact.innerGradient,
                Constants.Contact.outerGradient
            ]),
            center: .center,
            startRadius: Constants.Contact.startRadius,
            endRadius: Constants.Contact.endRadius
        )
    }
}

struct ContactRow: View {
    let data: ContactRowData
    let onAction: () -> Void

    var body: some View {
        VStack {
            
            Image(systemName: data.icon)
                .foregroundColor(.black.opacity(0.85))
                .font(.system(size: 26))
                .padding(.trailing, 4)
            
            Text(data.title)
                .font(.sfProBodyTextMedium(size: 33))
                .foregroundColor(.black)
                .padding(.bottom, 5)
            
            Button(action: onAction) {
                Text(data.text)
                    .font(.sfProRoundedTextRegular(size: 20))
                    .foregroundColor(.blue)
                    .underline()
            }
        }
        .multilineTextAlignment(.center)
    }
}
