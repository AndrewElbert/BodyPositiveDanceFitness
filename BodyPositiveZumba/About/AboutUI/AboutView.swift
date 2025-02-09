//
//  AboutView.swift
//  AboutUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

enum Action {
    case toggleExpansion(UUID)
    case handleButtonTap
}

struct AboutView: View, ActionableView {

    @Binding var viewState: AboutViewState
    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) private var dismiss

    init(
        viewState: Binding<AboutViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 22) {
                    HeaderView(header: viewState.header)
                        .layoutPriority(1)

                    ExpandableContentList(
                        contents: viewState.expandableContents,
                        onToggle: { id in
                            onAction?(.toggleExpansion(id))
                        }
                    )

                    ButtonList(
                        sections: viewState.sections,
                        onTap: { _ in
                            onAction?(.handleButtonTap)
                        }
                    )
                }
                .padding()
            }
        }
    }
}

private struct HeaderView: View {
    let header: AboutViewState.Header

    var body: some View {
        VStack(spacing: 11) {
            Text(header.title)
                .font(.sfProDisplayBold(size: 26))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
                .fixedSize(horizontal: false, vertical: true)

            Text(header.subtitle)
                .font(.sfProBodyTextMedium(size: 22))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .italic()
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, 22)
    }
}

private struct ExpandableContentList: View {
    let contents: [ExpandableParagraphModel]
    let onToggle: (UUID) -> Void

    var body: some View {
        ForEach(contents) { content in
            ExpandableParagraph(content: content, onToggle: onToggle)
                .equatable()
        }
    }
}

private struct ButtonList: View {
    let sections: [AboutMainSectionModel]
    let onTap: (AboutMainSectionModel) -> Void

    var body: some View {
        ForEach(sections) { section in
            ActionButton(section: section, onTap: onTap)
                .equatable()
        }
    }
}

struct ExpandableParagraph: View, Equatable {
    let content: ExpandableParagraphModel
    let onToggle: (UUID) -> Void

    private let headerBackground = ZStack {
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

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Button {
                withAnimation {
                    onToggle(content.id)
                }
            } label: {
                ExpandableHeader(
                    title: content.title,
                    isExpanded: content.isExpanded,
                    background: headerBackground
                )
            }

            if content.isExpanded {
                Text(content.content)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    static func == (lhs: ExpandableParagraph, rhs: ExpandableParagraph) -> Bool {
        lhs.content == rhs.content
    }
}

private struct ExpandableHeader: View {
    let title: String
    let isExpanded: Bool
    let background: AnyView

    init(title: String, isExpanded: Bool, background: some View) {
        self.title = title
        self.isExpanded = isExpanded
        self.background = AnyView(background)
    }

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
        .background(background)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Constants.Colors.darkOrange, lineWidth: 3)
        )
        .cornerRadius(8)
    }
}

struct ActionButton: View, Equatable {
    let section: AboutMainSectionModel
    let onTap: (AboutMainSectionModel) -> Void

    private let background = ZStack {
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

    var body: some View {
        Button {
            onTap(section)
        } label: {
            Text(section.title)
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(background)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Constants.Colors.darkerCyan, lineWidth: 3)
                )
                .cornerRadius(8)
        }
    }

    static func == (lhs: ActionButton, rhs: ActionButton) -> Bool {
        lhs.section == rhs.section
    }
}
