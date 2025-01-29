//
//  SideDrawerViewModel.swift
//  SideDrawerDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

class SideDrawerViewModel: ObservableObject {
    @Published var viewState: SideDrawerViewState = SideDrawerViewState()

    func toggleMenu() {
        viewState.isMenuOpen.toggle()
    }

    func closeMenu() {
        viewState.isMenuOpen = false
    }

    func openMenu() {
        viewState.isMenuOpen = true
    }

    func updateDragOffset(_ offset: CGSize) {
        viewState.dragOffset = offset
    }

    func endDragGesture(widthThreshold: CGFloat = 30) {
        if viewState.dragOffset.width < -widthThreshold {
            closeMenu()
        } else {
            openMenu()
        }
        viewState.dragOffset = .zero
    }
    
    func handleAction(_ action: SideDrawerView.Action) {
            switch action {
            case .joinNow:
                navigateJoinNow()
            case .classes:
                navigateClasses()
            case .newcomers:
                navigateNewcomers()
            case .about:
                navigateAbout()
            case .contact:
                navigateContact()
            case .signIn:
                navigateSignIn()
            case .subscription:
                navigateSubscription()
            }
        }

        // Separate function for each action
        private func navigateJoinNow() {
            // Code for the "Join Now" action
            print("Navigate to Join Now")
        }

        private func navigateClasses() {
            // Code for the "Classes" action
            print("Navigate to Classes")
        }

        private func navigateNewcomers() {
            // Code for the "Newcomers" action
            print("Navigate to Newcomers")
        }

        private func navigateAbout() {
            // Code for the "About" action
            print("Navigate to About")
        }

        private func navigateContact() {
            // Code for the "Contact" action
            print("Navigate to Contact")
        }

        private func navigateSignIn() {
            // Code for the "Sign In" action
            print("Navigate to Sign In")
        }

        private func navigateSubscription() {
            // Code for the "Subscription" action
            print("Navigate to Subscription")
        }
}
