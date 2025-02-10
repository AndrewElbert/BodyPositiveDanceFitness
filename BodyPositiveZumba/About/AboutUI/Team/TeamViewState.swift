//
//  TeamViewState.swift
//  BodyPositiveZumba
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

    var cards: [TeamCardModel] = Constants.Team.cards
}
