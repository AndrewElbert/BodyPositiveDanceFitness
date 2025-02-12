//
//  HomeViewModel.swift
//  HomeDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    var viewState = HomeViewState()

    let homeCoordinator: HomeCoordinator

    init(
        homeCoordinator: HomeCoordinator
    ) {
        self.homeCoordinator = homeCoordinator
    }
}
