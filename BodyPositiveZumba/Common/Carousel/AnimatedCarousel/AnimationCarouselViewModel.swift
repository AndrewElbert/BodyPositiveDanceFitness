//
//  AnimationCarouselViewModel.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import Combine
import SwiftUI

@MainActor
class AnimatedCarouselViewModel: ObservableObject {

    @Binding var viewState: AnimatedCarouselViewState

    init(
        viewState: Binding<AnimatedCarouselViewState>
    ) {
        self._viewState = viewState
    }

    func startAutoScroll() {
        guard viewState.isAnimating else { return }

        withAnimation(.smooth(duration: 0.75)) {
            viewState.currentIndex += 1
            viewState.currentIndex %= (viewState.items.count * 8)
        }
    }

    func handleDragChanged(_ translation: CGSize, in geometry: GeometryProxy) {
        viewState.dragOffset = translation.width
    }

    func handleDragEnded(_ translation: CGSize, in geometry: GeometryProxy) {
        let threshold = geometry.size.width * 0.3
        let totalItemCount = viewState.items.count * 8

        withAnimation(.easeInOut(duration: 0.5)) {
            if translation.width > threshold {
                viewState.currentIndex = (viewState.currentIndex - 1 + totalItemCount) % totalItemCount
            } else if translation.width < -threshold {
                viewState.currentIndex = (viewState.currentIndex + 1) % totalItemCount
            }
            viewState.dragOffset = 0
        }
    }
}
