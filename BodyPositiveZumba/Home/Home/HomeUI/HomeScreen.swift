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
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        HomeView(
            coordinator: sideDrawerCoordinator
        ) {
            action in
            switch action {
            }
        }
    }
}
