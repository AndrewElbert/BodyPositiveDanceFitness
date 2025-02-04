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
                                Color.cyan.opacity(0.7),
                                Color.cyan.opacity(0.6)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blur(radius: 50)
                    .padding(-40)

                GeometryReader { innerGeo in
                    HStack(spacing: 0) {
                        ForEach(0..<viewState.items.count * 8, id: \.self) { index in
                            Image(viewState.items[index % viewState.items.count].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: innerGeo.size.width, height: innerGeo.size.height)
                                .clipped()
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.cyan.opacity(0.2), lineWidth: 1)
                                )
                        }
                    }
                    .offset(x: -innerGeo.size.width * CGFloat(viewState.currentIndex) + viewState.dragOffset)
                    .animation(.smooth(duration: 0.5), value: viewState.currentIndex)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                onAction?(.dragChanged(value.translation, geometry))
                            }
                            .onEnded { value in
                                onAction?(.dragEnded(value.translation, geometry))
                            }
                    )
                }

                VStack {
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<viewState.items.count, id: \.self) { index in
                            Circle()
                                .fill(index == viewState.currentIndex % viewState.items.count ? Color.cyan : Color.gray.opacity(0.4))
                                .frame(width: 8, height: 8)
                                .scaleEffect(index == viewState.currentIndex % viewState.items.count ? 1.2 : 1.0)
                        }
                    }
                    .padding(.bottom, 16)
                    .animation(.smooth(duration: 0.3), value: viewState.currentIndex)
                }
            }
        }
        .onReceive(viewState.timer) { _ in
            onAction?(.startAutoScroll)
        }
    }
}
