//
//  FaqItemViewModel.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

@MainActor
class FaqItemViewModel: ObservableObject {

    @Binding var viewState: FaqItemViewState

    init(viewState: Binding<FaqItemViewState>) {
        self._viewState = viewState
    }

    func toggleExpanded() {
        viewState.isExpanded.toggle()

        if viewState.isExpanded {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.viewState.showText = true
            }
        } else {
            viewState.showText = false
            viewState.isClosing = true
        }
    }

    func handleClosingState() {
        if viewState.isClosing {
            viewState.showText = false
        }
    }
}
