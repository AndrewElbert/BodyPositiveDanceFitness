//
//  SwipableCarouselView.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct SwipableCarouselView<Content: View, T: Identifiable>: View, ActionableView {
    
    enum Action {
        case dragEnded(translation: CGFloat, cardWidth: CGFloat)
        case indexChanged
    }
    
    var onAction: ((Action) -> Void)?
    @Binding private var viewState: SwipableCarouselViewState<T>
    @GestureState private var dragOffset: CGFloat = 0
    private let content: (T, Bool) -> Content
    
    init(
        viewState: Binding<SwipableCarouselViewState<T>>,
        onAction: ((Action) -> Void)? = nil,
        @ViewBuilder content: @escaping (T, Bool) -> Content
    ) {
        self._viewState = viewState
        self.onAction = onAction
        self.content = content
    }
    
    private struct CarouselGeometry {
        let cardWidth: CGFloat
        let cardWithSpacing: CGFloat
        let displayOffset: CGFloat
        
        init(containerWidth: CGFloat, sideSpacing: CGFloat, spacing: CGFloat, currentIndex: Int) {
            self.cardWidth = max(0, containerWidth - (sideSpacing * 2))
            self.cardWithSpacing = cardWidth + spacing
            self.displayOffset = sideSpacing - (CGFloat(currentIndex + 1) * cardWithSpacing)
        }
    }
    
    private struct CarouselItemView: View {
        let content: Content
        let width: CGFloat
        
        var body: some View {
            content
                .frame(width: width)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            let geometry = CarouselGeometry(
                containerWidth: proxy.size.width,
                sideSpacing: viewState.sideSpacing,
                spacing: viewState.spacing,
                currentIndex: viewState.currentIndex
            )
            
            carouselContent(with: geometry)
                .offset(x: geometry.displayOffset + dragOffset)
                .animation(.easeInOut, value: dragOffset)
                .gesture(createDragGesture(cardWidth: geometry.cardWidth))
                .onChange(of: viewState.currentIndex) { _, _ in
                    onAction?(.indexChanged)
                }
        }
    }
    
    @ViewBuilder
    private func carouselContent(with geometry: CarouselGeometry) -> some View {
        HStack(spacing: viewState.spacing) {
            ForEach(
                Array(viewState.circularItems.enumerated()),
                id: \.offset
            ) { index, item in
                CarouselItemView(
                    content: content(item, index == viewState.currentIndex + 1),
                    width: geometry.cardWidth
                )
            }
        }
    }
    
    private func createDragGesture(cardWidth: CGFloat) -> some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation.width
            }
            .onEnded { value in
                onAction?(.dragEnded(
                    translation: value.translation.width,
                    cardWidth: cardWidth
                ))
            }
    }
}
