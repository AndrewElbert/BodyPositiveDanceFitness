//
//  InitialUI.swift
//  Home
//
//  Created by Andrew Elbert on 1/30/25.
//

import SwiftUI

struct InitialUI {

    @MainActor static func initialLoad(
        coordinator: InitialLoadCoordinator
    ) -> some View {
        InitialAppLoadScreen(
            viewModel: InitialAppLoadViewModel(
                coordinator: coordinator
            )
        )

    }

    @MainActor static func initialHome(
        homeCoordinator: HomeCoordinator,
        sideDrawerCoordinator: SideDrawerCoordinator
    ) -> some View {
        HomeScreen(
            sideDrawerCoordinator: sideDrawerCoordinator,
            viewModel: HomeViewModel(
                homeCoordinator: homeCoordinator
            )
        )
    }
}
