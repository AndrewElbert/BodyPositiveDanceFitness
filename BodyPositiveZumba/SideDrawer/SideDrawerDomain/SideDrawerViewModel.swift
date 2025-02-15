//
//  SideDrawerViewModel.swift
//  SideDrawerDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

class SideDrawerViewModel: ObservableObject {

    @Published public var viewState: SideDrawerViewState = SideDrawerViewState()
    let coordinator: SideDrawerCoordinator

    init(coordinator: SideDrawerCoordinator) {
        self.coordinator = coordinator
    }

    func updateDragOffset(_ offset: CGSize) {
        viewState.dragOffset = offset
    }

    func endDragGesture() {
        let dragThreshold: CGFloat = Constants.SideDrawer.frameWidth * 0.3

        if viewState.isMenuOpen {
            if viewState.dragOffset.width < -dragThreshold {
                closeMenu()
            } else {
                openMenu()
            }
        } else {
            if viewState.dragOffset.width > dragThreshold {
                openMenu()
            } else {
                closeMenu()
            }
        }

        withAnimation {
            viewState.dragOffset = .zero
        }
    }

    func closeMenu() {
        withAnimation {
            viewState.isMenuOpen = false
            viewState.dragOffset = .zero
        }
    }

    func openMenu() {
        withAnimation {
            viewState.isMenuOpen = true
            viewState.dragOffset = .zero
        }
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

    func navigateContact() {
        coordinator.sideDrawer_viewContact()
    }
}
