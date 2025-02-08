//
//  ExpandableSection.swift
//  SpaceRentalUI
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
        colorScheme == .dark ? Color.white : Color.black
    }

    init(
        viewState: Binding<ExpandableSectionViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
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
            .font(.system(size: 20, weight: .bold, design: .serif))
            .foregroundColor(.black)
    }

    private var expandCollapseIcon: some View {
        Image(systemName: viewState.isExpanded ? "chevron.down" : "chevron.right")
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .rotationEffect(.degrees(viewState.isExpanded ? 180 : 0))
            .animation(.easeInOut(duration: 0.4), value: viewState.isExpanded)
    }

    private var headerBackground: some View {
        ZStack {
            Color.white
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.orange.opacity(0.1),
                    Color.orange.opacity(0.7)
                ]),
                center: .center,
                startRadius: 8,
                endRadius: 88
            )
        }
    }

    private var headerBorder: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.cyan, lineWidth: 2)
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
