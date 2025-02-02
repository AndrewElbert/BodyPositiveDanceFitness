//
//  SideDrawerViewModel.swift
//  SideDrawerDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

class SideDrawerViewModel: ObservableObject {

    @Published public var viewState: SideDrawerViewState = SideDrawerViewState()

    unowned let coordinator: SideDrawerCoordinator

    init(coordinator: SideDrawerCoordinator) {
        self.coordinator = coordinator
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

    func navigateJoinNow() {
        coordinator.sideDrawer_viewJoinNow()
    }
    func navigateClasses() {
        coordinator.sideDrawer_viewClasses()
    }
    func navigateFaq() {
        coordinator.sideDrawer_viewFaq()
    }
    func navigateAbout() {
        coordinator.sideDrawer_viewAbout()
    }
    func navigateMassage() {
        coordinator.sideDrawer_viewMassage()
    }
    func navigatespaceRental() {
        coordinator.sideDrawer_viewSpaceRental()
    }
    func navigateSubscription() {
        print("entered subs")
        coordinator.sideDrawer_viewSubscription()
    }
}
