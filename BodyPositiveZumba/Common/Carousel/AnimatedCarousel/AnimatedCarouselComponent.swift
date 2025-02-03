//
//  AnimatedCarouselComponent.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselComponent: View {
    
    @ObservedObject private var viewModel: AnimatedCarouselViewModel

    public init(viewModel: AnimatedCarouselViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        AnimatedCarouselView(
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .dragChanged(let translation, let geomotry):
                viewModel.handleDragChanged(translation, in: geomotry)
            case .dragEnded(let translation, let geomotry):
                viewModel.handleDragEnded(translation, in: geomotry)
            case .startAutoScroll:
                viewModel.startAutoScroll()
            }
        }
    }
}
