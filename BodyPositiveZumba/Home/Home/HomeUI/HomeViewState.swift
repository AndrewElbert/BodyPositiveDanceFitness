//
//  HomeViewState.swift
//  Home
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct HomeViewState {

    var isCarouselExpanded: Bool = false
    var showCarousel: Bool = false
    var animatedCarouselViewState: AnimatedCarouselViewState = AnimatedCarouselViewState(images: Constants.Home.images)
    var deathScreenEnabled = false

    var showBookClassWebView: Bool = false
    var showJoinWebView: Bool = false
    var currentGreeting: String = ""

    var sideDrawerViewState: SideDrawerViewState = SideDrawerViewState()
}
