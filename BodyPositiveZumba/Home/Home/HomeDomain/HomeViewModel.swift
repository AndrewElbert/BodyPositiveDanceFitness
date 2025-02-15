//
//  HomeViewModel.swift
//  HomeDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {

    private let homeCoordinator: HomeCoordinator
    private var timerCancellable: AnyCancellable?

    @Published var viewState: HomeViewState = HomeViewState()

    init(homeCoordinator: HomeCoordinator) {
        self.homeCoordinator = homeCoordinator
        updateGreeting()
        startGreetingTimer()
    }

    func navigateAbout() {
        homeCoordinator.home_viewAbout()
    }

    func navigateClasses() {
        homeCoordinator.home_viewClasses()
    }

    func toggleBookClassWebView() {
        viewState.showBookClassWebView.toggle()
    }

    func toggleJoinWebView() {
        viewState.showJoinWebView.toggle()
    }

    private func startGreetingTimer() {
        timerCancellable = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.updateGreeting() }
    }

    private func updateGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())

        if hour >= 5 && hour < 12 {
            viewState.currentGreeting = "Good Morning!"
        } else if hour >= 12 && hour < 17 {
            viewState.currentGreeting = "Good Afternoon!"
        } else {
            viewState.currentGreeting = "Good Evening!"
        }
    }

    deinit {
        timerCancellable?.cancel()
    }
}
