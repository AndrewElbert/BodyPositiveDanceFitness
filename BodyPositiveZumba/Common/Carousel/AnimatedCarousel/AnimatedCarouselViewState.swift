//
//  AnimatedCarouselViewState.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselViewState {
    var images: [String]
    var currentIndex: Int
    var dragOffset: CGFloat
    
    init(
        images: [String] = [],
        currentIndex: Int = 0,
        dragOffset: CGFloat = 0
    ) {
        self.images = images
        self.currentIndex = currentIndex
        self.dragOffset = dragOffset
    }
    
    var repeatingImages: [String] {
        Array(repeating: images, count: 8).flatMap { $0 }
    }
    
    var currentImageIndex: Int {
        currentIndex % images.count
    }
}
