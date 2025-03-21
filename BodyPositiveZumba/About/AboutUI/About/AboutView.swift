//
//  AboutView.swift
//  About
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

    @Binding var viewState: AboutViewState
    @Environment(\.dismiss) private var dismiss
    var onAction: ((Action) -> Void)?

    var body: some View {
        ZStack {
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
        .preferredColorScheme(.light)
    }

    private var contentView: some View {
        ScrollView {
            VStack(spacing: 18) {
                headerTitle
                rainbowButtonSection
                coloredButtonSection
            }
            .padding()
        }
    }

    private var headerTitle: some View {
        VStack(spacing: 0) {
            Text(Constants.About.pageHeader)
                .font(.sfProDisplayBold(size: 22))
                .foregroundColor(.black)
                .italic()
            AnimatedLogoView(height: 170)
        }
        .padding(.top, 6)
        .padding(.bottom, 16)
    }

    private var rainbowButtonSection: some View {
        VStack(spacing: 20) {
            RainbowButton(title: Constants.About.whoPageTitle) {
                onAction?(.handleWhoAreWeTap)
            }
            RainbowButton(title: Constants.About.whatPageTitle) {
                onAction?(.handleWhatWeDoTap)
            }
        }
    }

    private var coloredButtonSection: some View {
        VStack(spacing: 20) {
            ForEach(Array(viewState.sections.prefix(2))) { section in
                ColoredButton(
                    title: section.title,
                    action: { handleButtonTap(section) },
                    strokeColor: Constants.Colors.navy
                )
            }
            ForEach(Array(viewState.sections.suffix(2))) { section in
                ColoredButton(
                    title: section.title,
                    action: { handleButtonTap(section) },
                    strokeColor: Constants.Colors.navy
                )
            }
        }
    }

    private func handleButtonTap(_ section: AboutMainSectionModel) {
        switch section.identifier {
        case Constants.About.actionButton1:
            onAction?(.handleTeamButtonTap)
        case Constants.About.actionButton2:
            onAction?(.handleClassesButtonTap)
        case Constants.About.actionButton3:
            onAction?(.handlePartnersButtonTap)
        case Constants.About.actionButton4:
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
        Button(
            action: {
                buttonVibration()
                onTap()
            }
        ) {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundColor(.black)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: Constants.Colors.rainbow),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 8
                        )
                )
                .cornerRadius(36)
        }
        .frame(height: 60)
    }
}
