//
//  MassageViewState.swift
//  MassageDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct MassageViewState {
    
    var pageTitle: String = Constants.Massage.pageTitle
    var pageBio: String = Constants.Massage.pageBio
    var isAnimating: Bool = false
    var bookingURL: WebViewURL? = nil
    var currentIndex: Int = 0
    
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

