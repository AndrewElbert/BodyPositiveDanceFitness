//
//  AboutView.swift
//  AboutUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct AboutView: View, ActionableView {

    enum Action {
        case toggleExpansion(UUID)
        case handleTeamButtonTap
        case handleClassesButtonTap
        case handlePartnersButtonTap
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

    // MARK: - Content Views

    private var contentView: some View {
        ScrollView {
            VStack(spacing: 22) {
                expandableContentSection
                buttonSection
            }
            .padding()
        }
    }

    private var expandableContentSection: some View {
        ForEach(viewState.expandableContents) { content in
            ExpandableParagraph(
                content: content,
                onToggle: { id in onAction?(.toggleExpansion(id)) }
            )
        }
    }

    private var buttonSection: some View {
        ForEach(Array(viewState.sections)) { section in
            ActionButton(section: section) { section in
                handleButtonTap(section)
            }
        }
    }

    // MARK: - Helper Methods

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

// MARK: - Subviews

struct ExpandableParagraph: View, Equatable {
    let content: ExpandableParagraphModel
    let onToggle: (UUID) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            expandableHeader

            if content.isExpanded {
                expandedContent
            }
        }
    }

    private var expandableHeader: some View {
        Button {
            withAnimation {
                onToggle(content.id)
            }
        } label: {
            ExpandableHeaderContent(
                title: content.title,
                isExpanded: content.isExpanded
            )
        }
    }

    private var expandedContent: some View {
        Text(content.content)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
            .fixedSize(horizontal: false, vertical: true)
    }

    static func == (lhs: ExpandableParagraph, rhs: ExpandableParagraph) -> Bool {
        lhs.content == rhs.content
    }
}

struct ExpandableHeaderContent: View {
    let title: String
    let isExpanded: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 22))
            Spacer()
            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
        }
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity)
        .background(headerBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Constants.Colors.darkOrange, lineWidth: 3)
        )
        .cornerRadius(8)
    }

    private var headerBackground: some View {
        ZStack {
            Color.white
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.orange.opacity(0.18),
                    Color.orange.opacity(0.4)
                ]),
                center: .center,
                startRadius: 22,
                endRadius: 122
            )
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
                        .stroke(Constants.Colors.darkerCyan, lineWidth: 3)
                )
                .cornerRadius(8)
        }
    }

    private var buttonBackground: some View {
        ZStack {
            Color(.white)
            RadialGradient(
                gradient: Gradient(colors: [
                    Constants.Colors.neonCyan.opacity(0.1),
                    Constants.Colors.neonCyan.opacity(0.3)
                ]),
                center: .center,
                startRadius: 22,
                endRadius: 122
            )
        }
    }

    static func == (lhs: ActionButton, rhs: ActionButton) -> Bool {
        lhs.section == rhs.section
    }
}
