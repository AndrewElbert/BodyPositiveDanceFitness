//
//  InfiniteCarouselViewState.swift
//  Carousel
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct InfiniteCarouselViewState<T: Identifiable> {

    var items: [T]
    var currentIndex: Int
    var spacing: CGFloat
    var sideSpacing: CGFloat

    init(
        items: [T] = [],
        currentIndex: Int = 0,
        spacing: CGFloat = 10,
        sideSpacing: CGFloat = 40
    ) {
        self.items = items
        self.currentIndex = currentIndex
        self.spacing = spacing
        self.sideSpacing = sideSpacing
    }

    var circularItems: [T] {
        guard let first = items.first, let last = items.last else { return items }
        return [last] + items + [first]
    }
}
