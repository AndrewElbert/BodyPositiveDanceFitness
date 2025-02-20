//
//  SpaceRentalUI.swift
//  SpaceRental
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct SpaceRentalUI {
    
    @MainActor static func spaceRentalPage(
    ) -> some View {
        SpaceRentalScreen(viewModel: SpaceRentalViewModel())
    }
}
