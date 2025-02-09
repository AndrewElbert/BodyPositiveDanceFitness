//
//  MassageViewState.swift
//  MassageDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct MassageViewState {

    var swipeAnimationViewState = SwipeAnimationViewState()
    var swipableCarouselViewState = SwipableCarouselViewState<CardModel>(
        items: [
            CardModel(
                id: UUID(),
                name: Constants.HeadShots.LindseyHerseyName,
                imageName: Constants.HeadShots.LindseyHerseyHeadShot,
                parlor: Constants.Massage.LindseyHerseyParlor,
                bio: Constants.Massage.LindseyHerseyBio
            ),
            CardModel(
                id: UUID(),
                name: Constants.HeadShots.ShelbySwannName,
                imageName: Constants.HeadShots.ShelbySwannHeadShot,
                parlor: Constants.Massage.ShelbySwannParlor,
                bio: Constants.Massage.ShelbySwannBio
            )
        ],
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

    var cards: [CardModel] = [
        CardModel(
            id: UUID(),
            name: Constants.HeadShots.LindseyHerseyName,
            imageName: Constants.HeadShots.LindseyHerseyHeadShot,
            parlor: Constants.Massage.LindseyHerseyParlor,
            bio: Constants.Massage.LindseyHerseyBio
        ),
        CardModel(
            id: UUID(),
            name: Constants.HeadShots.ShelbySwannName,
            imageName: Constants.HeadShots.ShelbySwannHeadShot,
            parlor: Constants.Massage.ShelbySwannParlor,
            bio: Constants.Massage.ShelbySwannBio
        )
    ]
}
