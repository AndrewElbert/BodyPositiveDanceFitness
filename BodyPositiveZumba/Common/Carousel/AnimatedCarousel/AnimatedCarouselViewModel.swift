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
    private var backgroundObserver: AnyCancellable?
    private var foregroundObserver: AnyCancellable?

    init(viewState: Binding<AnimatedCarouselViewState>) {

        self._viewState = viewState
        setupLifecycleObservers()
    }

    private func setupLifecycleObservers() {

        backgroundObserver = NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                self?.pauseCarousel()
            }

        foregroundObserver = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.resumeCarousel()
            }
    }

    func pauseCarousel() {

        viewState.timer.cancel()
    }

    func resumeCarousel() {

        viewState.timer.cancel()
        viewState.timer = PreciseSequenceTimer(baseInterval: 2.6)
        viewState.timer.start()
    }

    func startAutoScroll() {

        guard viewState.isAnimating else { return }

        withAnimation(.smooth(duration: 10)) {
            viewState.currentIndex += 1
            viewState.currentIndex %= (viewState.items.count * 8)
        }
    }

    deinit {

        backgroundObserver?.cancel()
        foregroundObserver?.cancel()
    }
}
