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
    func navigateAbout() { homeCoordinator.home_viewAbout() }
    func navigatePhotos() { }
    func navigateClasses() { homeCoordinator.home_viewClasses() }
    @Published var currentGreeting: String = ""
    @Published var logoScale: CGFloat = 1.0
    @Published var logoOpacity: Double = 1.0
    @Published var logoOffsetY: CGFloat = 0.0
    private var timerCancellable: AnyCancellable?
    init(homeCoordinator: HomeCoordinator) {
        self.homeCoordinator = homeCoordinator
        updateGreeting()
        startGreetingTimer()
    }
    private func startGreetingTimer() {
        timerCancellable = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.updateGreeting() }
    }
    private func updateGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 5 && hour < 12 { currentGreeting = "Good Morning,\nCarson!" }
        else if hour >= 12 && hour < 17 { currentGreeting = "Good Afternoon,\nBen!" }
        else { currentGreeting = "Good Evening,\nAndrew!" }
    }
    deinit { timerCancellable?.cancel() }
}




