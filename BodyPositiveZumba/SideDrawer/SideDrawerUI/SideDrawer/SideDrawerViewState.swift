//
//  SideDrawerViewState.swift
//  SideDrawer
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct SideDrawerViewState {

    var isMenuOpen: Bool = false
    var showDimBackground: Bool = false
    var dragOffset: CGSize = .zero
    var contactIsPressed: Bool = false
    var showJoinNowWebView = false

    var drawerButtons: [DrawerButtonViewState] = [
        DrawerButtonViewState(
            title: Constants.SideDrawer.joinNowText,
            icon: Constants.SideDrawer.joinNowImage,
            type: .joinNow
        ),
        DrawerButtonViewState(
            title: Constants.SideDrawer.classesText,
            icon: Constants.SideDrawer.classesImage,
            type: .classes
        ),
        DrawerButtonViewState(
            title: Constants.SideDrawer.faqText,
            icon: Constants.SideDrawer.faqImage,
            type: .faq
        ),
        DrawerButtonViewState(
            title: Constants.SideDrawer.aboutText,
            icon: Constants.SideDrawer.aboutImage,
            type: .about
        ),
        DrawerButtonViewState(
            title: Constants.SideDrawer.massageText,
            icon: Constants.SideDrawer.massageImage,
            type: .massage
        ),
        DrawerButtonViewState(
            title: Constants.SideDrawer.spaceRentalText,
            icon: Constants.SideDrawer.spaceRentalImage,
            type: .spaceRental
        )
    ]
}
