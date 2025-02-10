//
//  AboutUI.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/8/25.
//

import SwiftUI

struct AboutUI {
    @MainActor static func aboutPage(
        aboutCoordinator: AboutCoordinator
    ) -> some View {
        AboutScreen(
            viewModel: AboutViewModel(
                aboutCoordinator: aboutCoordinator
            )
        )
    }

    static func teamPage() -> some View {
        TeamScreen(
            viewModel: TeamViewModel()
        )
    }
}
