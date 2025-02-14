//
//  AnimatedCarouselView.swift
//  Carousel
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselView: View, ActionableView {

    enum Action {
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
                                Constants.Colors.neonCyan.opacity(0.3),
                                Constants.Colors.neonCyan.opacity(0.5)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blur(radius: 60)
                    .padding(-40)

                GeometryReader { innerGeo in
                    HStack(spacing: 0) {
                        ForEach(0..<viewState.items.count * 8, id: \.self) { index in
                            GeometryReader { itemGeo in
                                let midX = itemGeo.frame(in: .global).midX
                                let screenWidth = geometry.size.width
                                let distance = abs(screenWidth / 2 - midX)
                                let scale = max(0.85, 1 - distance / screenWidth)
                                let rotation = (screenWidth / 2 - midX) / 15

                                Image(viewState.items[index % viewState.items.count].imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: itemGeo.size.width, height: itemGeo.size.height)
                                    .clipped()
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.cyan.opacity(0.2), lineWidth: 1)
                                    )
                                    .scaleEffect(scale)
                                    .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            .frame(width: innerGeo.size.width, height: innerGeo.size.height)
                        }
                    }

                    .offset(x: -innerGeo.size.width * CGFloat(viewState.currentIndex))
                    .animation(.interactiveSpring(response: 3.3, dampingFraction: 0.8, blendDuration: 0.5), value: viewState.currentIndex)
                }

                VStack {
                    Spacer()
                    HStack(spacing: 10) {
                        ForEach(0..<viewState.items.count, id: \.self) { index in
                            Capsule()
                                .fill(
                                    index == viewState.currentIndex % viewState.items.count ? Constants.Colors.neonCyan : Color.gray.opacity(0.4)
                                )
                                .frame(width: 10, height: 10)
                                .animation(.easeInOut(duration: 0.3), value: viewState.currentIndex)
                        }
                    }
                    .padding(.bottom, 16)
                }
            }
        }

        .onReceive(viewState.timer) { _ in
            onAction?(.startAutoScroll)
        }
    }
}
