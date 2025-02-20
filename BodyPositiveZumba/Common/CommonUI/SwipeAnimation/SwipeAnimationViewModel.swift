//
//  SwipeAnimationViewModel.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

@MainActor
class SwipeAnimationViewModel: ObservableObject {

    @Binding var viewState: SwipeAnimationViewState

    init(
        viewState: Binding<SwipeAnimationViewState>
    ) {
        self._viewState = viewState
    }

}
