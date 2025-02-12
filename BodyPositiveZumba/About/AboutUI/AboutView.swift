//
//  AboutView.swift
//  AboutUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct AboutView: View, ActionableView {

    enum Action {
        case handleTeamButtonTap
        case handleClassesButtonTap
        case handlePartnersButtonTap
        case handleWhoAreWeTap
        case handleWhatWeDoTap
    }

    @Binding private var viewState: AboutViewState
    @Environment(\.dismiss) private var dismiss
    var onAction: ((Action) -> Void)?

    init(
        viewState: Binding<AboutViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        NavigationStack {
            contentView
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
        .sheet(item: $viewState.mediaUrl) { webView in
            WebViewContainer(url: webView.url, title: webView.title)
        }
    }

    private var contentView: some View {
        ScrollView {
            VStack(spacing: 22) {
                headerTitle
                extraButtonSection
                buttonSection
            }
            .padding()
        }
    }

    private var headerTitle: some View {

        VStack(spacing: 0) {
            Text("About ")
                .font(.sfProDisplayBold(size: 22))
                .foregroundColor(.black)
                .italic()

            Image(Constants.Common.logoName)
                .resizable()
                .scaledToFit()
                .frame(height: 160)
        }
        .padding(.top, 6)
        .padding(.bottom, 16)
    }

    private var extraButtonSection: some View {
        VStack(spacing: 20) {
            RainbowButton(title: "Who are we?") {
                onAction?(.handleWhoAreWeTap)
            }
            RainbowButton(title: "What do we do?") {
                onAction?(.handleWhatWeDoTap)
            }
        }
    }

    private var buttonSection: some View {
        ForEach(Array(viewState.sections)) { section in
            ActionButton(section: section) { section in
                handleButtonTap(section)
            }
        }
    }

    private func handleButtonTap(_ section: AboutMainSectionModel) {
        switch section.identifier {
        case "team":
            onAction?(.handleTeamButtonTap)
        case "classes":
            onAction?(.handleClassesButtonTap)
        case "partners":
            onAction?(.handlePartnersButtonTap)
        case "media":
            viewState.mediaUrl = WebViewURL(
                title: Constants.About.mediaTitle,
                url: URL(string: Constants.About.mediaURL)!
            )
        default:
            break
        }
    }
}

struct RainbowButton: View {
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        .red,
                                        .orange,
                                        .yellow,
                                        .green,
                                        .blue,
                                        .indigo,
                                        .purple
                                    ]
                                ),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 6
                        )
                )
                .cornerRadius(8)
        }
    }
}

struct ActionButton: View, Equatable {
    let section: AboutMainSectionModel
    let onTap: (AboutMainSectionModel) -> Void

    var body: some View {
        Button {
            onTap(section)
        } label: {
            Text(section.title)
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(buttonBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Constants.Colors.darkerCyan, lineWidth: 6)
                )
                .cornerRadius(8)
        }
    }

    private var buttonBackground: some View {
        ZStack {
            Color.white
            RadialGradient(
                gradient: Gradient(colors: [
                    Constants.Colors.neonCyan.opacity(0.05),
                    Constants.Colors.neonCyan.opacity(0.2)
                ]),
                center: .center,
                startRadius: 55,
                endRadius: 122
            )
        }
    }

    static func == (lhs: ActionButton, rhs: ActionButton) -> Bool {
        lhs.section == rhs.section
    }
}
