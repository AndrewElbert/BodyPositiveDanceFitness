//
//  ClassesViewState.swift
//  Classes
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct ClassesViewState {

    var swipeAnimationViewState = SwipeAnimationViewState()

    var carouselViewState = SwipableCarouselViewState(
        items: DanceClass.allCases,
        spacing: 10,
        sideSpacing: 60
    )

    var currentDanceClass: DanceClass {
        let count = carouselViewState.items.count
        let safeIndex = ((carouselViewState.currentIndex % count) + count) % count
        return carouselViewState.items[safeIndex]
    }

    var showSwipeAnimation: Bool = true
    var isBioExpanded: Bool = false
    var viewCalendarWebView: WebViewURL?
    var joinNowURL: WebViewURL?
}
