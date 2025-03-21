//
//  InitialAppLoadViewModel.swift
//  Home
//
//  Created by Andrew Elbert on 1/30/25.
//

import SwiftUI

@MainActor
class InitialAppLoadViewModel: ObservableObject {

    @Published var viewState = InitialAppLoadViewState()
    var homeLoadDuration: Double = 0
    let coordinator: InitialLoadCoordinator

    init(coordinator: InitialLoadCoordinator) {
        self.coordinator = coordinator
        homeLoadDuration = viewState.barLoadDuration + viewState.barLoadPause
        startScreenLoad()
    }

    func startLoading() {

        withAnimation(.linear(duration: viewState.barLoadDuration)) {
            viewState.progress = 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + viewState.barLoadDuration + viewState.colorChangeDelay) {
            self.fadeToNeonCyan()
        }
    }

    func fadeToNeonCyan() {

        withAnimation(.easeIn(duration: 0.4)) {

            viewState.barOutlineColor = Color.orange
        }

        withAnimation(.easeIn(duration: 0.8)) {

            startShootingStar()

            viewState.barColorStart = viewState.neonCyan
            viewState.barColorEnd = viewState.endColor
            viewState.textColor = viewState.endColor
            viewState.logoShadowOpacity = 0.55

            startVibration()
        }
    }

    func startAnimations() {

        viewState.fadeInProgress = 1.0
        viewState.textColor = Color.blue.opacity(0.8)
        viewState.barColorStart = Color.cyan.opacity(0.25)
        viewState.barColorEnd = Color.blue
    }

    func navigateToHomeScreen() {

        coordinator.initialLoad_viewHome()
    }

    private func startScreenLoad() {

        DispatchQueue.main.asyncAfter(deadline: .now() + homeLoadDuration) {
            self.viewState.showHomeScreen = true
        }
    }

    private func startShootingStar() {

        viewState.showShootingStar = true
    }

    private func startVibration() {

        DispatchQueue.global(qos: .default).async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
        }
    }
}
