//
//  PartnersViewState.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

struct PartnersViewState {

    var carouselViewState = SwipableCarouselViewState(
        items: Partner.allCases,
        spacing: 10,
        sideSpacing: 60
    )

    var currentDanceClass: Partner {
        let count = carouselViewState.items.count
        let safeIndex = ((carouselViewState.currentIndex % count) + count) % count
        return carouselViewState.items[safeIndex]
    }
    
    var displayURL: WebViewURL?
}
