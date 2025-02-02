//
//  AnimationCarouselViewModel.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI
import Combine

@MainActor
class AnimatedCarouselViewModel: ObservableObject {
    
    @Binding var viewState: AnimatedCarouselViewState
    private var timer: AnyCancellable?
    
    init(viewState: Binding<AnimatedCarouselViewState>) {
        self._viewState = viewState
        setupTimer()
    }
    
    private func setupTimer() {
        timer = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.advanceToNextImage()
            }
    }
    
    func handleDragEnd(translation: CGFloat, screenWidth: CGFloat) {
        let threshold = screenWidth * 0.3
        
        withAnimation(.easeInOut(duration: 1.25)) {
            if translation > threshold {
                viewState.currentIndex -= 1
            } else if translation < -threshold {
                viewState.currentIndex += 1
            }
            viewState.dragOffset = 0
        }
        
        viewState.currentIndex = (viewState.currentIndex + viewState.repeatingImages.count) % viewState.repeatingImages.count
    }
    
    func updateDragOffset(_ offset: CGFloat) {
        viewState.dragOffset = offset
    }
    
    private func advanceToNextImage() {
        withAnimation(.easeInOut(duration: 1.25)) {
            viewState.currentIndex += 1
            viewState.currentIndex = (viewState.currentIndex + viewState.repeatingImages.count) % viewState.repeatingImages.count
        }
    }
}
