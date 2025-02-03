//
//  AnimatedCarouselView.swift
//  Carousel
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselView: View, ActionableView {
    
    enum Action {
        case dragChanged(CGSize, GeometryProxy)
        case dragEnded(CGSize, GeometryProxy)
        case startAutoScroll
    }
    
    @Binding var viewState: AnimatedCarouselViewState
    var onAction: ((Action) -> Void)?
    
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

                HStack(spacing: 0) {
                    ForEach(0..<viewState.items.count * 8, id: \.self) { index in
                        Image(viewState.items[index % viewState.items.count].imageName)
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
                .frame(width: geometry.size.width * CGFloat(viewState.items.count * 8), height: geometry.size.height)
                .offset(x: -geometry.size.width * CGFloat(viewState.currentIndex) + viewState.dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            onAction?(.dragChanged(value.translation, geometry))
                        }
                        .onEnded { value in
                            onAction?(.dragEnded(value.translation, geometry))
                        }
                )
                .animation(.easeInOut(duration: 1.25), value: viewState.dragOffset)

                HStack(spacing: 8) {
                    ForEach(0..<viewState.items.count, id: \.self) { index in
                        Circle()
                            .fill(index == viewState.currentIndex % viewState.items.count ? Color.cyan : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                            .scaleEffect(index == viewState.currentIndex % viewState.items.count ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: viewState.currentIndex)
                    }
                }
                .padding(.bottom, 16)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onReceive(viewState.timer) { _ in
            onAction?(.startAutoScroll)
        }
    }
}
