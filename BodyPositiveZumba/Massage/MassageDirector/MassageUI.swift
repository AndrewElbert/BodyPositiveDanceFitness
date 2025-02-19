//
//  MassageUI.swift
//  Massage
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct MassageUI {

    @MainActor static func massagePage(
    ) -> some View {
        MassageScreen(
            viewModel: MassageViewModel(
            )
        )
    }
}
