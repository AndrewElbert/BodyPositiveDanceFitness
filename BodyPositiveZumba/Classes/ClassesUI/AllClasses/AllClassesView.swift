//
//  AllClassesView.swift
//  Classes
//
//  Created by Andrew Elbert on 2/12/25.
//

import SwiftUI

struct AllClassesView: View {

    @State var viewState: AllClassesViewState
    @Environment(\.dismiss) private var dismiss
    @State private var selectedClass: DanceClass?
    @Environment(\.colorScheme) private var colorScheme

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

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
                                onBook: { viewState.showWebView = true },
                                onInfoTap: {
                                    selectedClass = danceClass
                                }
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
            .sheet(item: $selectedClass) { danceClass in
                classInfoSheet(
                    danceClass: danceClass,
                    adaptiveTextColor: adaptiveTextColor,
                    joinNowAction: { viewState.showWebView = true },
                    showingInfo: Binding(
                        get: { selectedClass != nil },
                        set: { if !$0 { selectedClass = nil } }
                    )
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
            .preferredColorScheme(.light)
        }
    }
}

struct BookButton: View {
    
    let action: () -> Void

    var body: some View {
        Button(
            action: {
                buttonVibration()
                action()
            }
        ) {
            Text(Constants.Classes.bookButtonText)
                .font(.sfProRoundedTextRegular(size: 15))
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white.opacity(0.4))
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
    let onInfoTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(danceClass.rawValue)
                    .font(.sfProBodyTextMedium(size: 16))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.leading, 16)

                Spacer()

                Button(
                    action: {
                        buttonVibration()
                        onInfoTap()
                    }
                ) {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .foregroundStyle(.white.opacity(0.4))

                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(danceClass.color.opacity(0.9))
                    }
                }

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
    url: URL(string: Constants.JoinNow.joinNowUrl)!
)
