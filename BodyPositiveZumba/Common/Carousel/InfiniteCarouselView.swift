//
//  InfiniteCarouselView.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct InfiniteCarouselView<Content: View, T: Identifiable>: View {
    var items: [T]
    @Binding var currentIndex: Int
    var spacing: CGFloat = 10
    var sideSpacing: CGFloat = 40
    var content: (T, Bool) -> Content

    private var circularItems: [T] {
        guard let first = items.first, let last = items.last else { return items }
        return [last] + items + [first]
    }

    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            let cardWidth = max(0, proxy.size.width - (sideSpacing * 2))
            let cardWithSpacing = cardWidth + spacing
            let displayIndex = CGFloat(currentIndex + 1)

            HStack(spacing: spacing) {
                ForEach(Array(circularItems.enumerated()), id: \.offset) { index, item in
                    content(item, index == currentIndex + 1)
                        .frame(width: cardWidth)
                }
            }
            .offset(x: sideSpacing - (displayIndex * cardWithSpacing) + dragOffset)
            .animation(.easeInOut, value: dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = cardWidth / 2
                        var newIndex = currentIndex
                        if value.translation.width < -threshold {
                            newIndex += 1
                        } else if value.translation.width > threshold {
                            newIndex -= 1
                        }
                        withAnimation(.easeInOut) {
                            currentIndex = newIndex
                        }
                    }
            )
            .onChange(of: currentIndex) { _, newValue in
                if newValue < 0 {
                    DispatchQueue.main.async {
                        withAnimation(.none) {
                            currentIndex = items.count - 1
                        }
                    }
                } else if newValue >= items.count {
                    DispatchQueue.main.async {
                        withAnimation(.none) {
                            currentIndex = 0
                        }
                    }
                }
            }
        }
    }
}
