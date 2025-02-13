//
//  AllClassesView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/12/25.
//

import SwiftUI

struct AllClassesView: View {

    @State var viewState: AllClassesViewState
    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    Text(Constants.Classes.viewAllClassesPageTitle)
                        .font(.sfProDisplayBold(size: 34))
                        .padding(.top, 30)
                        .padding(.horizontal)
                        .padding(.bottom, 16)

                    LazyVStack(spacing: 0) {
                        ForEach(viewState.classes) { danceClass in
                            DanceClassRow(
                                danceClass: danceClass,
                                onBook: { viewState.showWebView = true }
                            )
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(isPresented: $viewState.showWebView) {
                WebViewContainer(
                    url: webViewURL.url,
                    title: webViewURL.title
                )
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton {
                    dismiss()
                }
                ToolbarButton.closeButton {
                    dismiss()
                }
            }
        }
    }
}

struct BookButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(Constants.Classes.bookButtonText)
                .font(.sfProRoundedTextRegular(size: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                )
                .foregroundColor(.black)
        }
    }
}

struct DanceClassRow: View {

    let danceClass: DanceClass
    let onBook: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(danceClass.rawValue)
                    .font(.sfProBodyTextMedium(size: 18))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.leading, 16)

                Spacer()

                BookButton(action: onBook)
                    .padding(.trailing, 8)
            }
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(danceClass.color.opacity(0.25))
            )

            Divider()
                .background(Color.black.opacity(0.3))
                .padding(.vertical, 8)
        }
    }
}

private let webViewURL = WebViewURL(
    title: Constants.Classes.bookNowWebviewTitle,
    url: URL(string: Constants.JoinNow.bookClassUrl)!
)
