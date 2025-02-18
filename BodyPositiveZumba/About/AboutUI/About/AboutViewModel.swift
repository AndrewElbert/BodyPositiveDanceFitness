//
//  AboutViewModel.swift
//  About
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

@MainActor
final class AboutViewModel: ObservableObject {

    @Published var viewState: AboutViewState
    let aboutCoordinator: AboutCoordinator

    init(
        viewState: AboutViewState = .default,
        aboutCoordinator: AboutCoordinator
    ) {
        self.viewState = viewState
        self.aboutCoordinator = aboutCoordinator
    }

    func handleWhoButtonTap() {
        aboutCoordinator.about_viewWho()
    }

    func handleWhatButtonTap() {
        aboutCoordinator.about_viewWhat()
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
