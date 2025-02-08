//
//  AboutUI.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/8/25.
//

import SwiftUI

struct AboutUI {
    @MainActor static func aboutPage() -> some View {
        AboutScreen(
            viewModel: AboutViewModel()
        )
    }
}
