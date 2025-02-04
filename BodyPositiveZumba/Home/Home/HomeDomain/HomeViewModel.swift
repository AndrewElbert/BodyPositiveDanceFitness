//
//  HomeViewModel.swift
//  HomeDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    unowned let sideDrawerCoordinator: SideDrawerCoordinator

    var viewState = HomeViewState()

    unowned let homeCoordinator: HomeCoordinator

    init(
        homeCoordinator: HomeCoordinator,
        sideDrawerCoordinator: SideDrawerCoordinator
    ) {
        self.homeCoordinator = homeCoordinator
        self.sideDrawerCoordinator = sideDrawerCoordinator
    }
}
