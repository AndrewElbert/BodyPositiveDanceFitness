//
//  TeamViewModel.swift
//  About
//
//  Created by Andrew Elbert on 2/9/25.
//

import SwiftUI

@MainActor
class TeamViewModel: ObservableObject {

    @Published var currentIndex: Int = 0
    @Published var viewState: TeamViewState = TeamViewState()

    var currentBioData: TeamBioModel {
        let count = viewState.bios.count
        guard count > 0 else { return TeamBioModel(bio: "", firstName: "Team Member") }

        var index = viewState.swipableCarouselViewState.currentIndex
        while index < 0 {
            index += count
        }
        return viewState.bios[index % count]
    }

    func toggleBioExpanded() {
        viewState.isBioExpanded.toggle()
    }
}
