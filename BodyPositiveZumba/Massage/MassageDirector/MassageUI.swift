//
//  MassageUI.swift
//  MassageDirector
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct MassageUI {
    static func massagePage(
    ) -> some View {
        MassageView(
            viewModel: MassageViewModel(
            )
        )
    }
}
