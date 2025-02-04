//
//  ExpandableSectionViewModel.swift
//  SpaceRentalUI
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

class ExpandableSectionViewModel: ObservableObject {

    @Binding var viewState: ExpandableSectionViewState

    init(
        viewState: Binding<ExpandableSectionViewState>
    ) {
        self._viewState = viewState
    }

    func toggleExpansion() {
        viewState.isExpanded.toggle()
    }
}
