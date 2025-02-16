//
//  HomeScreen.swift
//  HomeUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct HomeScreen: View {

    private var sideDrawerCoordinator: SideDrawerCoordinator
    @ObservedObject private var viewModel: HomeViewModel

    public init(
        sideDrawerCoordinator: SideDrawerCoordinator,
        viewModel: HomeViewModel
    ) {
        self.sideDrawerCoordinator = sideDrawerCoordinator
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        HomeView(
            coordinator: sideDrawerCoordinator,
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .viewClasses:
                viewModel.navigateClasses()
            case .about:
                viewModel.navigateAbout()
                case .joinNow:
                viewModel.toggleJoinWebView()
            case .bookClass:
                viewModel.toggleBookClassWebView()
            }
        }
    }
}
