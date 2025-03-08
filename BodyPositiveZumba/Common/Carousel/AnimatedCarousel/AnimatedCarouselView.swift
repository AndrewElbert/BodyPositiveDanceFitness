//
//  AnimatedCarouselView.swift
//  Common
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

    private let repetitions = 8
    private let gradientColors = [
        Constants.Colors.neonCyan.opacity(0.3),
        Constants.Colors.neonCyan.opacity(0.5)
    ]

    private var currentItemIndex: Int {
        viewState.currentIndex % viewState.items.count
    }

    private struct CarouselItemView: View {
        let image: String
        let size: CGSize
        let screenWidth: CGFloat
        let midX: CGFloat

        private var transformationValues: (scale: CGFloat, rotation: CGFloat) {
            let distance = abs(screenWidth / 2 - midX)
            return (
                scale: max(0.85, 1 - distance / screenWidth),
                rotation: (screenWidth / 2 - midX) / 15
            )
        }

        var body: some View {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.cyan.opacity(0.2), lineWidth: 1)
                )
                .scaleEffect(transformationValues.scale)
                .rotation3DEffect(
                    .degrees(transformationValues.rotation),
                    axis: (x: 0, y: 1, z: 0)
                )
                .shadow(
                    color: .black.opacity(0.3),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                carouselContent(in: geometry)
                pageIndicators
            }
        }
        .onAppear() {
            onAction?(.startAutoScroll)
        }
        .onReceive(viewState.timer) { _ in
            onAction?(.startAutoScroll)
        }
    }

    private var backgroundGradient: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .blur(radius: 60)
            .padding(-40)
    }

    private func carouselContent(in geometry: GeometryProxy) -> some View {
        GeometryReader { innerGeo in
            HStack(spacing: 0) {
                ForEach(0..<viewState.items.count * repetitions, id: \.self) { index in
                    GeometryReader { itemGeo in
                        CarouselItemView(
                            image: viewState.items[index % viewState.items.count].imageName,
                            size: itemGeo.size,
                            screenWidth: geometry.size.width,
                            midX: itemGeo.frame(in: .global).midX
                        )
                    }
                    .frame(
                        width: innerGeo.size.width,
                        height: innerGeo.size.height
                    )
                }
            }
            .offset(x: -innerGeo.size.width * CGFloat(viewState.currentIndex))
            .animation(
                .interactiveSpring(
                    response: 3.3,
                    dampingFraction: 0.8,
                    blendDuration: 0.5
                ),
                value: viewState.currentIndex
            )
        }
    }

    private var pageIndicators: some View {
        VStack {
            Spacer()
            HStack(spacing: 10) {
                ForEach(0..<viewState.items.count, id: \.self) { index in
                    Capsule()
                        .fill(
                            index == currentItemIndex ?
                            Constants.Colors.neonCyan : Color.gray.opacity(0.4)
                        )
                        .frame(width: 10, height: 10)
                        .animation(.easeInOut(duration: 0.3), value: currentItemIndex)
                }
            }
            .padding(.bottom, 16)
        }
    }
}
