//
//  MassageViewState.swift
//  MassageDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct MassageViewState {

    var swipeAnimationViewState = SwipeAnimationViewState()
    var swipableCarouselViewState = SwipableCarouselViewState<MassageCardModel>(
        items: Constants.Massage.cards,
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

    var cards: [MassageCardModel] = Constants.Massage.cards
}
