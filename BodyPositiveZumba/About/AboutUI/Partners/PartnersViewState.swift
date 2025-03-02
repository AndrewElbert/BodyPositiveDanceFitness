//
//  PartnersViewState.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

struct PartnersViewState {

    var swipeAnimationViewState = SwipeAnimationViewState()

    var carouselViewState = SwipableCarouselViewState(
        items: Partner.allCases,
        spacing: 80,
        sideSpacing: 60
    )

    var currentPartner: Partner {
        let count = carouselViewState.items.count
        let safeIndex = ((carouselViewState.currentIndex % count) + count) % count
        return carouselViewState.items[safeIndex]
    }

    var showSwipeAnimation = true
    var displayURL: WebViewURL?
    var showBorder: Bool = false
}
