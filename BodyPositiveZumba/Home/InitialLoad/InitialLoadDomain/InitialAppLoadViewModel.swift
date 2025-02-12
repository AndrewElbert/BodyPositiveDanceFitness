//
//  InitialAppLoadViewModel 2.swift
//  InitialLoadDomain
//
//  Created by Andrew Elbert on 1/30/25.
//

import SwiftUI

@Observable
class InitialAppLoadViewModel: ObservableObject {

    var viewState = InitialAppLoadViewState()
    var homeLoadDuration: Double = 0

    let coordinator: InitialLoadCoordinator

    init(
        coordinator: InitialLoadCoordinator
    ) {
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
        withAnimation(.easeIn(duration: 0.8)) {
            viewState.barColorStart = viewState.neonCyan
            viewState.barColorEnd = Color(red: 0, green: 0, blue: 0.5)
            viewState.textColor = Color(red: 0, green: 0, blue: 0.5)
        }
        withAnimation(.easeIn(duration: 0.4)) {
            viewState.barOutlineColor = Color.orange
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
}
