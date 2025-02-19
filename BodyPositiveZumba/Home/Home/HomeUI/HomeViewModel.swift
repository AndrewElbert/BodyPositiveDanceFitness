//
//  HomeViewModel.swift
//  Home
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {

    private let homeCoordinator: HomeCoordinator
    private var timerCancellable: AnyCancellable?
    private var activeNotification: AnyCancellable?
    private var lastRemoteConfigFetchDate: Date?

    @Published var viewState: HomeViewState = HomeViewState()

    init(homeCoordinator: HomeCoordinator) {
        self.homeCoordinator = homeCoordinator

        updateGreeting()
        startGreetingTimer()
        startNotifications()

        // MARK: Firebase Implementation

//        fetchRemoteConfig()
//        activeNotification = NotificationCenter.default
//            .publisher(for: UIApplication.didBecomeActiveNotification)
//            .sink { [weak self] _ in
//                self?.fetchRemoteConfig()
//            }
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

    private func startNotifications() {
        NotificationManager.shared.scheduleAllNotifications()
    }

    deinit {
        timerCancellable?.cancel()
        activeNotification?.cancel()
    }

    // MARK: Firebase implementation

//    private func fetchRemoteConfig() {
//        let now = Date()
//        if let lastFetch = lastRemoteConfigFetchDate, now.timeIntervalSince(lastFetch) < 60 * 60 {
//            return
//        }
//
//        lastRemoteConfigFetchDate = now
//
//        RemoteConfigManager.shared.fetchRemoteValues { _ in
//            DispatchQueue.main.async {
//                let newValue = RemoteConfigManager.shared.getDeathScreenEnabled()
//                self.viewState.deathScreenEnabled = newValue
//            }
//        }
//    }
}
