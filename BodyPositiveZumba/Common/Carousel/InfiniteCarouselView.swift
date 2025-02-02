//
//  InfiniteCarouselView.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct InfiniteCarouselView<Content: View, T: Identifiable>: View, ActionableView {

    enum Action {
        case dragEnded(translation: CGFloat, cardWidth: CGFloat)
        case indexChanged
    }

    var onAction: ((Action) -> Void)?
    @Binding var viewState: InfiniteCarouselViewState<T>
    @GestureState private var dragOffset: CGFloat = 0
    private let content: (T, Bool) -> Content

    init(
        viewState: Binding<InfiniteCarouselViewState<T>>,
        onAction: ((Action) -> Void)? = nil,
        @ViewBuilder content: @escaping (T, Bool) -> Content
    ) {
        self._viewState = viewState
        self.onAction = onAction
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            let cardWidth = max(0, proxy.size.width - (viewState.sideSpacing * 2))
            let cardWithSpacing = cardWidth + viewState.spacing
            let displayIndex = CGFloat(viewState.currentIndex + 1)

            HStack(spacing: viewState.spacing) {
                ForEach(Array(viewState.circularItems.enumerated()), id: \.offset) { index, item in
                    content(item, index == viewState.currentIndex + 1)
                        .frame(width: cardWidth)
                }
            }
            .offset(x: viewState.sideSpacing - (displayIndex * cardWithSpacing) + dragOffset)
            .animation(.easeInOut, value: dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        onAction?(.dragEnded(translation: value.translation.width, cardWidth: cardWidth))
                    }
            )
            .onChange(of: viewState.currentIndex) { _, _ in
                onAction?(.indexChanged)
            }
        }
    }
}
