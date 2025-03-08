//
//  AnimatedCarouselViewModel.swift
//  Common
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

        withAnimation(.smooth(duration: 10)) {
            viewState.currentIndex += 1
            viewState.currentIndex %= (viewState.items.count * 8)
        }
    }
}
