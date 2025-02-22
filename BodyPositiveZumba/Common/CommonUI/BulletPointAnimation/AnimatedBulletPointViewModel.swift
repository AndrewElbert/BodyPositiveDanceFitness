//
//  AnimatedBulletPointViewModel.swift
//  Common
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

@MainActor
class AnimatedBulletPointViewModel: ObservableObject {

    @Binding var viewState: AnimatedBulletPointViewState

    init(viewState: Binding<AnimatedBulletPointViewState>) {
        self._viewState = viewState
    }

    func startAnimation() {
        withAnimation(.easeInOut(duration: 3.3)) {
            viewState.isAnimating.toggle()
            viewState.sparkleOpacity = 1
        }
    }
}
