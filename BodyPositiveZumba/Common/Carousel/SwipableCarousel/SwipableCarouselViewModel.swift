//
//  SwipableCarouselViewModel.swift
//  Carousel
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

@MainActor
class SwipableCarouselViewModel<T: Identifiable>: ObservableObject {

    @Binding var viewState: SwipableCarouselViewState<T>

    init(viewState: Binding<SwipableCarouselViewState<T>>) {
        self._viewState = viewState
    }

    func handleDragEnd(translation: CGFloat, cardWidth: CGFloat) {
        let threshold: CGFloat = cardWidth / 2
        var newIndex = $viewState.wrappedValue.currentIndex

        if translation < -threshold {
            newIndex += 1
        } else if translation > threshold {
            newIndex -= 1
        }

        withAnimation(.easeInOut) {
            $viewState.wrappedValue.currentIndex = newIndex
        }
    }

    func handleIndexChange() {
        if $viewState.wrappedValue.currentIndex < 0 {
            withAnimation(.none) {
                $viewState.wrappedValue.currentIndex = $viewState.wrappedValue.items.count - 1
            }
        } else if $viewState.wrappedValue.currentIndex >= $viewState.wrappedValue.items.count {
            withAnimation(.none) {
                $viewState.wrappedValue.currentIndex = 0
            }
        }
    }
}
