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

        static let instagramLink: String = NSLocalizedString(
            "https://www.instagram.com/",
            comment: "instagram link")

        static let facebookLink: String = NSLocalizedString(
            "https://www.facebook.com/",
            comment: "instagram link")

        static let tradeMarkSlogan: String = NSLocalizedString(
            "Are You Ready For The Happiest Workout In Maine?™",
            comment: "trademarked slogan")

        static let logoName: String = NSLocalizedString(
            "BodyPositiveLogo",
            comment: "string file name")

        static let companyName: String = NSLocalizedString(
            "© Body Positive Dance Fitness LLC 2023",
            comment: "company name")

    }

    enum Home {
        static let buttonImage: String = NSLocalizedString(
            "line.horizontal.3",
            comment: "system image name"
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
        static let contactText: String = NSLocalizedString(
            "Contact",
            comment: "contact button text"
        )
        static let contactImage: String = NSLocalizedString(
            "envelope.circle",
            comment: "contact button image"
        )
        static let instagramLogo: String = NSLocalizedString(
            "InstagramLogo",
            comment: "instagram logo image"
        )
        static let facebookLogo: String = NSLocalizedString(
            "FacebookLogo",
            comment: "facebook logo image"
        )
        static let newsletterText: String = NSLocalizedString(
            "Subscribe to our newsletter!",
            comment: "newsletter text"
        )
        static let newsletterImage: String = NSLocalizedString(
            "arrow.right",
            comment: "newsletter image"
        )

        static let newsLetterFontSize: CGFloat = 15
        static let newsLetterImageSize: CGFloat = 15
        static let startRadius: CGFloat = 40
        static let endRadius: CGFloat = 400
        static let backgroundOpacity: Double = 0.6
        static let animationDuration: Double = 0.33
        static let frameWidth: CGFloat = 250
        static let buttonSpacing: CGFloat = 33
        static let outerCircleColorRadius: Color = Color(red: 0.0, green: 0.9, blue: 0.94)
        static let innerCircleColorRadius: Color = Color(red: 0.967, green: 0.698, blue: 0.243)
    }
}
