//
//  ExpandableSection.swift
//  SpaceRental
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct ExpandableSection: View, ActionableView {

    enum Action {
        case toggleExpansion
    }

    @Binding var viewState: ExpandableSectionViewState
    var onAction: ((Action) -> Void)?
    @Environment(\.colorScheme) private var colorScheme

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    var body: some View {
        VStack(spacing: 12) {
            headerButton

            if viewState.isExpanded {
                contentSection
            }
        }
    }

    private var headerButton: some View {
        Button(action: { onAction?(.toggleExpansion) }) {
            HStack {
                titleText
                Spacer()
                expandCollapseIcon
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(headerBackground)
            .overlay(headerBorder)
            .cornerRadius(10)
        }
    }

    private var titleText: some View {
        Text(viewState.title)
            .font(.sfProRoundedTextSemibold(size: 20))
            .foregroundColor(.black)
    }

    private var expandCollapseIcon: some View {
        Image(systemName: viewState.isExpanded ? "chevron.down" : "chevron.right")
            .font(.sfProBodyTextBold(size: 18))
            .foregroundColor(Constants.Colors.darkOrange)
    }

    private var headerBackground: some View {
        ZStack {
            Color.white
            RadialGradient(
                gradient: Gradient(colors: [
                    .orange.opacity(0.05),
                    .orange.opacity(0.2)
                ]),
                center: .center,
                startRadius: 55,
                endRadius: 122
            )
        }
    }

    private var headerBorder: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.orange, lineWidth: 6)
    }

    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(viewState.items.indices, id: \.self) { index in
                AnimatedBulletPointComponent(
                    viewModel: AnimatedBulletPointViewModel(
                        viewState: $viewState.animatedBulletPointViewStates[index]
                    )
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .transition(.scale.combined(with: .opacity))
    }
}
