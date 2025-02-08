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

    init(
        viewState: AboutViewState = .default
    ) {
        self.viewState = viewState
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

    func handleButtonTap() {
        print("tapped")
    }
}
