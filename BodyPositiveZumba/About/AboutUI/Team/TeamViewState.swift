//
//  TeamViewState.swift
//  About
//
//  Created by Andrew Elbert on 2/9/25.
//

import SwiftUI

struct TeamViewState {

    var swipeAnimationViewState = SwipeAnimationViewState()
    var swipableCarouselViewState = SwipableCarouselViewState<TeamCardModel>(
        items: Constants.Team.cards,
        currentIndex: 0,
        spacing: 10,
        sideSpacing: 40
    )

    var pageTitle: String = Constants.Massage.pageTitle
    var pageBio: String = Constants.Massage.pageBio
    var isAnimating: Bool = false
    var showSwipeAnimation = true
    var bookingURL: WebViewURL?
    var showCarousel: Bool = false
    var isBioExpanded: Bool = false

    var cards: [TeamCardModel] = Constants.Team.cards
    var bios: [TeamBioModel] = Constants.Team.bios

    var normalizedIndex: Int {
        let count = bios.count
        guard count > 0 else {
            return 0
        }

        let index = swipableCarouselViewState.currentIndex
        return ((index % count) + count) % count
    }
}
