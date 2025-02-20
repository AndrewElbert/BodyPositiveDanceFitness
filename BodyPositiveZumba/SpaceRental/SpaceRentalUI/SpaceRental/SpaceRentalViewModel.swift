//
//  SpaceRentalViewModel.swift
//  SpaceRental
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

@MainActor
class SpaceRentalViewModel: ObservableObject {

    @Published var viewState = SpaceRentalViewState()

    func toggleMessage() {
        viewState.showMessage.toggle()
    }
}
