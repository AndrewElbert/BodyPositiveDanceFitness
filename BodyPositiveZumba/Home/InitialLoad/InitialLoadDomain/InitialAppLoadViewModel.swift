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
    let loadingDuration: Double = Double.random(in: 1.11...3.33)

    init() {
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

    private func startScreenLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            self.viewState.showHomeScreen = true
        }
    }
}
