//
//  SideDrawerViewModel.swift
//  SideDrawerDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

class SideDrawerViewModel: ObservableObject {

    @Published public var viewState: SideDrawerViewState = SideDrawerViewState()

    init (
        viewState: SideDrawerViewState = SideDrawerViewState()
    ) {
        self.viewState = viewState
    }

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

    // Separate function for each action
    func navigateJoinNow() {
        // Code for the "Join Now" action
        print("Navigate to Join Now")
    }
    func navigateClasses() {
        // Code for the "Classes" action
        print("Navigate to Classes")
    }
    func navigateNewcomers() {
        // Code for the "Newcomers" action
        print("Navigate to Newcomers")
    }
    func navigateAbout() {
        // Code for the "About" action
        print("Navigate to About")
    }
    func navigateContact() {
        // Code for the "Contact" action
        print("Navigate to Contact")
    }
    func navigateSignIn() {
        // Code for the "Sign In" action
        print("Navigate to Sign In")
    }
    func navigateSubscription() {
        // Code for the "Subscription" action
        print("Navigate to Subscription")
    }
}
