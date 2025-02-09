//
//  InitialUI.swift
//  HomeScreenDirector
//
//  Created by Andrew Elbert on 1/30/25.
//

import SwiftUI

struct InitialUI {

    static func initialLoad(
        coordinator: InitialLoadCoordinator
    ) -> some View {
        InitialAppLoadScreen(
            viewModel: InitialAppLoadViewModel(
                coordinator: coordinator
            )
        )

    }

    static func initialHome(
        homeCoordinator: HomeRootCoordinator
    ) -> some View {
        HomeScreen(
            viewModel: HomeViewModel(
                homeCoordinator: homeCoordinator
            )
        )
    }
}
