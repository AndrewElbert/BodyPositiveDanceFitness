//
//  HomeViewModel.swift
//  HomeDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    var viewState = HomeViewState()

    unowned let coordinator: HomeCoordinator

    init(
        coordinator: HomeCoordinator
    ) {
        self.coordinator = coordinator
    }
}
