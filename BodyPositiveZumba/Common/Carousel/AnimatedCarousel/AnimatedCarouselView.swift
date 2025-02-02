//
//  AnimatedCarouselView.swift
//  Carousel
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselView: View, ActionableView {
    enum Action {
        case dragChanged(CGFloat)
        case dragEnded(translation: CGFloat, screenWidth: CGFloat)
        case timerFired
    }
    
    var onAction: ((Action) -> Void)?
    @Binding private var viewState: AnimatedCarouselViewState
    
    init(
        viewState: Binding<AnimatedCarouselViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundView()
                CarouselContentView(
                    geometry: geometry,
                    viewState: viewState,
                    onDragChanged: { offset in
                        onAction?(.dragChanged(offset))
                    },
                    onDragEnded: { translation in
                        onAction?(.dragEnded(
                            translation: translation,
                            screenWidth: geometry.size.width
                        ))
                    }
                )
                PageIndicatorsView(viewState: viewState)
            }
        }
    }
}

private struct BackgroundView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.cyan.opacity(0.6),
                        Color.cyan.opacity(0.5)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .blur(radius: 40)
    }
}

private struct CarouselContentView: View {
    let geometry: GeometryProxy
    let viewState: AnimatedCarouselViewState
    let onDragChanged: (CGFloat) -> Void
    let onDragEnded: (CGFloat) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<viewState.repeatingImages.count, id: \.self) { index in
                ImageCell(
                    imageName: viewState.repeatingImages[index],
                    geometry: geometry
                )
            }
        }
        .offset(x: -CGFloat(viewState.currentIndex) * geometry.size.width + viewState.dragOffset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    onDragChanged(value.translation.width)
                }
                .onEnded { value in
                    onDragEnded(value.translation.width)
                }
        )
    }
}

private struct ImageCell: View {
    let imageName: String
    let geometry: GeometryProxy
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.cyan.opacity(0.3), lineWidth: 2)
                    .shadow(color: .cyan.opacity(0.3), radius: 5)
            )
    }
}

private struct PageIndicatorsView: View {
    let viewState: AnimatedCarouselViewState
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<viewState.images.count, id: \.self) { index in
                Circle()
                    .fill(index == viewState.currentImageIndex ? Color.white : Color.white.opacity(0.5))
                    .frame(width: 8, height: 8)
            }
        }
    }
}
