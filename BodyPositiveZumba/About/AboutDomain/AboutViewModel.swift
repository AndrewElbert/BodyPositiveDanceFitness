//
//  AboutViewModel.swift
//  AboutDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

@MainActor
final class AboutViewModel: ObservableObject {
    @Published var viewState: AboutViewState
    unowned let aboutCoordinator: AboutCoordinator

    init(
        viewState: AboutViewState = .default,
        aboutCoordinator: AboutCoordinator
    ) {
        self.viewState = viewState
        self.aboutCoordinator = aboutCoordinator
    }

    func toggleExpansion(for id: UUID) {
        viewState.expandableContents = viewState.expandableContents.map { content in
            var content = content
            if content.id == id {
                content.isExpanded.toggle()
            }
            return content
        }
    }

    func handleTeamButtonTap() {
        aboutCoordinator.about_viewTeam()
    }

    func handleClassesButtonTap() {
        aboutCoordinator.about_viewClasses()
    }

    func handlePartnersButtonTap() {
        aboutCoordinator.about_viewPartners()
    }
}
