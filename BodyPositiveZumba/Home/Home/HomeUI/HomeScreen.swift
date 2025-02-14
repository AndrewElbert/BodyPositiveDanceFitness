//
//  HomeScreen.swift
//  HomeUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    private var sideDrawerCoordinator: SideDrawerCoordinator
    
    public init(
        sideDrawerCoordinator: SideDrawerCoordinator,
        viewModel: HomeViewModel
    ) {
        self.sideDrawerCoordinator = sideDrawerCoordinator
        self.viewModel = viewModel
    }
    
    var body: some View {
        HomeView(
            coordinator: sideDrawerCoordinator,
            viewModel: viewModel
        ) { action in
            switch action {
            case .viewClasses:
                viewModel.navigateClasses()
            case .about:
                viewModel.navigateAbout()
            case .joinNow:
                viewModel.toggleJoinWebView()
                break
            case .bookClass:
                viewModel.toggleBookClassWebView()
            }
        }
    }
}
