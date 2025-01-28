//
//  Constants.swift
//  Common
//
//  Created by Andrew Elbert on 1/26/25.
//

import Foundation
import SwiftUI

struct Constants {
    enum Common {

        static let tradeMarkSlogan: String = NSLocalizedString(
            "Are You Ready For The Happiest Workout In Maine?™",
            comment: "trademarked slogan")

        static let logoName: String = NSLocalizedString(
            "BodyPositiveLogo",
            comment: "string file name")
    }

    enum Home {
        static let buttonImage: String = NSLocalizedString(
            "line.horizontal.3",
            comment: "system name"
        )
        static let grettingMessage: String = NSLocalizedString(
            "Welcome to Body Positive Dance Fitness",
            comment: "home screen greeting message"
        )
    }

    enum SideDrawer {

        static let iconSize: CGFloat = 24
        static let fontSize: CGFloat = 18
        // Yellow
        static let buttonStartColor: Color = Color(red: 0.957, green: 0.698, blue: 0.243)
        // Orange
        static let buttonEndColor: Color = Color(red: 0.933, green: 0.427, blue: 0.176)
        static let cornerRadius: CGFloat = 15

        static let signInText: String = NSLocalizedString(
            "Sign In",
            comment: "sign in button text"
        )
        static let signInImage: String = NSLocalizedString(
            "person.badge.plus",
            comment: "sign in button image"
        )
        static let joinNowText: String = NSLocalizedString(
            "Join Now!",
            comment: "join now button text"
        )
        static let joinNowImage: String = NSLocalizedString(
            "person.crop.circle",
            comment: "join now button image"
        )
        static let aboutText: String = NSLocalizedString(
            "About Us",
            comment: "about button text"
        )
        static let aboutImage: String = NSLocalizedString(
            "info.circle",
            comment: "about button image"
        )
        static let faqText: String = NSLocalizedString(
            "Newcomers / FAQ",
            comment: "faq button text"
        )
        static let faqImage: String = NSLocalizedString(
            "questionmark.circle",
            comment: "faq button image"
        )
        static let classesText: String = NSLocalizedString(
            "Classes",
            comment: "classes button text"
        )
        static let classesImage: String = NSLocalizedString(
            "calendar",
            comment: "classes button image"
        )
        static let backgroundOpacity: Double = 0.6
        static let animationDuration: Double = 0.33
        static let frameWidth: CGFloat = 250
        static let buttonSpacing: CGFloat = 44
        static let outerCircleColorRadius: Color = Color(red: 0.0, green: 0.9, blue: 0.94)
        static let innerCircleColorRadius: Color = Color(.white)
    }
}
