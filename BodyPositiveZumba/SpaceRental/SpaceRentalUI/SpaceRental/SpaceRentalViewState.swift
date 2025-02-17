//
//  SpaceRentalViewState.swift
//  SpaceRental
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct SpaceRentalViewState {

    var amenitiesSectionState: ExpandableSectionViewState = ExpandableSectionViewState(
        title: Constants.SpaceRental.expandableButton1Text,
        items: Constants.SpaceRental.amenities
    )

    var privateEventsSectionState: ExpandableSectionViewState = ExpandableSectionViewState(
        title: Constants.SpaceRental.expandableButton2Text,
        items: Constants.SpaceRental.privateEvents
    )

    var spaceRentalSectionState: ExpandableSectionViewState = ExpandableSectionViewState(
        title: Constants.SpaceRental.expandableButton3Text,
        items: Constants.SpaceRental.spaceRental
    )

    var animatedCarouselViewState: AnimatedCarouselViewState = AnimatedCarouselViewState()

    var showCarousel: Bool = false
    var showMessage = false
    let spaceImages = Constants.SpaceRental.spaceImages
}
