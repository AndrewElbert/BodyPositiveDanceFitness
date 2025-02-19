//
//  ContactUI.swift
//  Contact
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactUI {
    
    @MainActor static func contactPage(
    ) -> some View {
        ContactScreen(
            viewModel: ContactViewModel(
            )
        )
    }
}
