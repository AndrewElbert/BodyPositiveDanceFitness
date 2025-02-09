//
//  SideDrawerUI.swift
//  SideDrawerDirector
//
//  Created by Andrew Elbert on 2/9/25.
//

import Foundation
import SwiftUI

struct SideDrawerUI {

    static func sideDrawer(
        sideDrawerCoordinator: SideDrawerCoordinator
    ) -> some View {
        SideDrawerComponent(
            viewModel: SideDrawerViewModel(
                coordinator: sideDrawerCoordinator
            )
        )
    }
}
