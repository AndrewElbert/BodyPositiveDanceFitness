//
//  AboutUI.swift
//  About
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

    @MainActor static func teamPage() -> some View {
        TeamScreen(
            viewModel: TeamViewModel()
        )
    }

    @MainActor static func partnersPage() -> some View {
        PartnersScreen(
            viewModel: PartnersViewModel()
        )
    }

    @MainActor static func whoPage() -> some View {
        WhoAreWeScreen(
            viewModel: WhoAreWeViewModel()
        )
    }

    @MainActor static func whatPage() -> some View {
        WhatWeDoScreen(
            viewModel: WhatWeDoViewModel()
        )
    }
}
