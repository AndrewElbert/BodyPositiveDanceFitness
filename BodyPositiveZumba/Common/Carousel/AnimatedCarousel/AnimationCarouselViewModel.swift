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
        withAnimation(.easeInOut(duration: 1.25)) {
            viewState.currentIndex += 1
            viewState.currentIndex = (viewState.currentIndex + viewState.items.count * 8) % (viewState.items.count * 8)
        }
    }

    func handleDragChanged(_ translation: CGSize, in geometry: GeometryProxy) {
        viewState.dragOffset = translation.width
    }

    func handleDragEnded(_ translation: CGSize, in geometry: GeometryProxy) {
        let threshold = geometry.size.width * 0.3
        withAnimation(.easeInOut(duration: 1.25)) {
            if translation.width > threshold {
                viewState.currentIndex -= 1
            } else if translation.width < -threshold {
                viewState.currentIndex += 1
            }
            viewState.dragOffset = 0
        }
        viewState.currentIndex = (viewState.currentIndex + viewState.items.count * 8) % (viewState.items.count * 8)
    }
}
