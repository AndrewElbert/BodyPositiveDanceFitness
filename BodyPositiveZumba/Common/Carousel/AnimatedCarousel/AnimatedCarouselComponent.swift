//
//  AnimatedCarouselComponent.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselComponent: View {
    @ObservedObject private var viewModel: AnimatedCarouselViewModel
    
    init(viewModel: AnimatedCarouselViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        AnimatedCarouselView(
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .dragChanged(let offset):
                viewModel.updateDragOffset(offset)
            case .dragEnded(let translation, let screenWidth):
                viewModel.handleDragEnd(translation: translation, screenWidth: screenWidth)
            case .timerFired:
                // Handle timer action if needed
                break
            }
        }
    }
}
