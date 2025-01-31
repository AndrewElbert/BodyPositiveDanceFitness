//
//  HomeScreen.swift
//  HomeUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct HomeScreen: View {

    @ObservedObject private var viewModel: HomeViewModel

    public init(
        viewModel: HomeViewModel
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        HomeView(
            coordinator: viewModel.sideDrawerCoordinator
        ) { action in
            switch action {
            }
        }
    }
}
