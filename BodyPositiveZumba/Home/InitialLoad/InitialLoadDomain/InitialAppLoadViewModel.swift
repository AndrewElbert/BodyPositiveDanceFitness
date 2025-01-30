//
//  InitialAppLoadViewModel.swift
//  InitialLoad
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

@Observable
class InitialAppLoadViewModel: ObservableObject {

    var viewState = InitialAppLoadViewState()
    var homeLoadDuration: Double = 0
    
    unowned let coordinator: InitialLoadCoordinator

    init(
        coordinator: InitialLoadCoordinator
    ) {
        self.coordinator = coordinator
        homeLoadDuration = viewState.barLoadDuration + 0.22
        startScreenLoad()
    }

    func startLoading() {
        withAnimation {
            viewState.progress = 1.0
        }
    }

    func startAnimations() {
        viewState.fadeInProgress = 1.0
        viewState.textColor = Color.blue.opacity(0.9)
        viewState.barColorStart = Color.cyan.opacity(0.6)
        viewState.barColorEnd = Color.blue.opacity(0.9)
    }
    
    func navigateToHomeScreen() {
        coordinator.initialLoad_viewHome()
    }

    private func startScreenLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + homeLoadDuration ) {
            self.viewState.showHomeScreen = true
        }
    }
}
