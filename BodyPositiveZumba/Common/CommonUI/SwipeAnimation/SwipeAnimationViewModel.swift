//
//  SwipeAnimationViewModel.swift
//  CommonUI
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

@MainActor
class SwipeAnimationViewModel: ObservableObject {

    @Published var viewState: SwipeAnimationViewState

    init(
        viewState: SwipeAnimationViewState
    ) {
        self.viewState = viewState
    }

}
