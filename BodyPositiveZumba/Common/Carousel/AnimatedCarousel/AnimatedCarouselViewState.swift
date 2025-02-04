//
//  AnimatedCarouselViewState.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedCarouselViewState {

    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    var images: [String]
    var items: [CarouselItemModel]
    var currentIndex: Int = 0
    var dragOffset: CGFloat = 0
    var isAnimating: Bool = true
    var autoScrollInterval: Double = 2.5

    init(
        images: [String]? = nil,
        autoScrollInterval: Double = 2.5
    ) {
        self.images = images ?? Constants.SpaceRental.spaceImages
        self.items = self.images.map {
            CarouselItemModel(
                id: UUID(),
                imageName: $0
            )
        }
        self.autoScrollInterval = autoScrollInterval
    }
}
