//
//  NewcomersUI.swift
//  NewcomersDiretor
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct NewcomersUI {
    static func newcomersPage(
    ) -> some View {
        NewcomersScreen(
            viewModel: NewcomersViewModel(
            )
        )
    }
}
