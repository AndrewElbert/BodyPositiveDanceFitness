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
}
