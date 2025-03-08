//
//  AnimatedCarouselViewState.swift
//  Common
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselViewState {

    var timer = Timer.publish(every: 2.6, on: .main, in: .common).autoconnect()
    var images: [String]
    var items: [CarouselItemModel]
    var currentIndex: Int = 0
    var dragOffset: CGFloat = 0
    var isAnimating: Bool = true

    init(
        images: [String]? = nil
    ) {
        self.images = images ?? Constants.SpaceRental.spaceImages
        self.items = self.images.map {
            CarouselItemModel(
                id: UUID(),
                imageName: $0
            )
        }
    }
}
