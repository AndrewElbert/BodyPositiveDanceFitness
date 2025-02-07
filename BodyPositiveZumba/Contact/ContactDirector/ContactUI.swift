//
//  ContactUI.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactUI {
    static func contactPage(
    ) -> some View {
        ContactScreen(
            viewModel: ContactViewModel(
            )
        )
    }
}
