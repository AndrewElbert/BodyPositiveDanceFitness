//
//  InfiniteCarouselComponent.swift
//  Carousel
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct InfiniteCarouselComponent<Content: View, T: Identifiable>: View {

    @ObservedObject private var viewModel: InfiniteCarouselViewModel<T>
    private let content: (T, Bool) -> Content

    init(
        viewModel: InfiniteCarouselViewModel<T>,
        @ViewBuilder content: @escaping (T, Bool) -> Content
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content
    }

    var body: some View {
        InfiniteCarouselView<Content, T>(
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .dragEnded(let translation, let cardWidth):
                viewModel.handleDragEnd(translation: translation, cardWidth: cardWidth)
            case .indexChanged:
                viewModel.handleIndexChange()
            }
        } content: { item, isSelected in
            content(item, isSelected)
        }
    }
}
