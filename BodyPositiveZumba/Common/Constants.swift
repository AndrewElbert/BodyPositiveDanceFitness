//
//  Constants.swift
//  Common
//
//  Created by Andrew Elbert on 1/26/25.
//

import Foundation
import SwiftUI

// swiftlint:disable line_length
struct Constants {

    // MARK: Colors

    enum Colors {

        static let neonCyan: Color = Color(red: 0.0, green: 1.0, blue: 1.0)
        static let darkerCyan: Color = Color(red: 0.0, green: 0.88, blue: 0.88)
        static let darkOrange = Color(red: 0.8, green: 0.3, blue: 0.1)

    }

    // MARK: Common

    enum Common {

        static let instagramLink: String = NSLocalizedString(
            "https://www.instagram.com/bodypositivedancefitness?igsh=MXdtOGgwazFkYjZ1ag%3D%3D&utm_source=qr",
            comment: "ig link")

        static let facebookLink: String = NSLocalizedString(
            "https://www.facebook.com/share/1BPU8L8kyF/?mibextid=wwXIfr",
            comment: "fb link")

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

    // MARK: FAQ

    enum FAQ {

        struct FAQItem {
            let question: String
            let answer: String
        }

        static let faqItems: [FAQItem] = [
            FAQItem(
                question: "Do I need dance experience?",
                answer: "No! We welcome anyone and everyone who has a desire to move their body!"
            ),
            FAQItem(
                question: "What should I wear?",
                answer: "Most people wear comfortable workout clothes. And please, no street shoes. We love our floors!"
            ),
            FAQItem(
                question: "Do you have changing rooms?",
                answer: "No, but we do have several large bathrooms with space to change."
            ),
            FAQItem(
                question: "Where do I store my things?",
                answer: "There is plenty of space for coats and shoes in our lobby, as well as cubbies inside our dance rooms!"
            ),
            FAQItem(
                question: "What if I'm late for class (or need to leave early)?",
                answer: "All good! We understand that life doesn’t always run on a schedule, but we want you to be able to dance. Just check in with the front desk."
            ),
            FAQItem(
                question: "Do I need to make a reservation?",
                answer: "Reservations are always helpful, but not required. Even if you’ve made a reservation, please check in at the front desk. If you have a reservation and don’t check in, we will assume you were in the class, and your account will reflect that. If you’ve made a reservation but cannot attend, please cancel online, or call the studio at 207-536-4617."
            ),
            FAQItem(
                question: "How do I pay?",
                answer: "You can pay online when you register, with a card at the studio, via Venmo, or cash."
            ),
            FAQItem(
                question: "What do you recommend to someone new?",
                answer: "Come for the fun, the community, and the moves! Don’t worry about getting it “right.” As long as you’re moving and having fun, that’s great! And, it usually takes a few classes to feel comfortable with the routines."
            ),
            FAQItem(
                question: "How many classes a day am I allowed to take?",
                answer: "As many as you like! All day dancing is encouraged!"
            ),
            FAQItem(
                question: "Do I book a massage with you?",
                answer: "Please book your massage directly with the massage therapist. Info and scheduling info can be found on the massage room door at the studio. Or, to book a massage with Lindsey online, please visit ladyloveholistics.com."
            ),
            FAQItem(
                question: "Do you take cash?",
                answer: "Yes!"
            ),
            FAQItem(
                question: "Can I try it for free before I sign up?",
                answer: "Yes!! Make a reservation online or drop in any time!"
            ),
            FAQItem(
                question: "Can I leave my kid in the lobby?",
                answer: "No. We are not equipped or licensed to provide childcare."
            ),
            FAQItem(
                question: "Will I get shut out if I’m late?",
                answer: "No! We have wonderful, understanding front desk staff that want to get you in the room dancing! Just check in with them."
            ),
            FAQItem(
                question: "Are you sensitive about your plumbing?",
                answer: "Yes! We have had several expensive plumbing emergencies due to 'flushable' items being flushed. Please dispose of everything except toilet paper in our trash cans."
            ),
            FAQItem(
                question: "Can I have my private party with you?",
                answer: "Yes! We are happy to host your special event! Think staff gathering, team building event, TikTok party, bachelorette party, wedding dance lessons, you name it! Please email Hilary at hilary@bodypositivedancefitness.com."
            ),
            FAQItem(
                question: "Do you sell water?",
                answer: "No, due to the environmental impact of plastic bottles. We sell brand-new BPDF water bottles, as well as upcycled water bottles for a minimal fee. Please use our bottle fillers/water fountains."
            )
        ]

        static let pageTitle = "Frequently Asked Questions"
        static let chevron = "chevron.down"
    }

    // MARK: Headshots

    enum HeadShots {

        static let ShelbySwannHeadShot: String = NSLocalizedString(
            "ShelbySwannHeadShot",
            comment: "Shelby Swann HeadShot"
        )

        static let ShelbySwannName: String = NSLocalizedString(
            "Shelby Swann",
            comment: "Shelby Swann"
        )

        static let LindseyHerseyHeadShot: String = NSLocalizedString(
            "LindseyHerseyHeadShot",
            comment: "Lindsey Hersey Head Shot"
        )

        static let LindseyHerseyName: String = NSLocalizedString(
            "Lindsey Hersey",
            comment: "Lindsey Hersey"
        )

    }

    // MARK: Home

    enum Home {
        static let buttonImage: String = NSLocalizedString(
            "line.horizontal.3",
            comment: "system image name"
        )
        static let grettingMessage: String = NSLocalizedString(
            "Welcome to Body Positive Dance Fitness",
            comment: "home screen greeting message"
        )
        static let tradeMarkSloganSize: CGFloat = 22
    }

    // MARK: Massage

    enum Massage {
        static let pageTitle: String = "Massage Services"
        static let pageBio: String = "Partnering with Lindsey (Lady Love Holistics) and Shelby (Swann's Healing Elements), we now offer sports massage, therapy, health coaching, and Reiki for our members and community!"

        static let LindseyHerseyParlor: String = "Lady Love Holistics"
        static let ShelbySwannParlor: String = "Swann's Healing Elements"
        static let LindseyHerseyBio: String = "Lindsey is an experienced massage therapist who specializes in sports massage, health coaching, and Reiki."
        static let ShelbySwannBio: String = "Shelby is a skilled massage therapist offering a range of healing techniques, including Reiki and massage therapy."
        static let ladyLoveHolisticURL: String = "https://ladyloveholistics.com/"
        static let swannsHealingElementsURL: String = "https://swanns-healing-elements.square.site/"

        static let buttonText: String = "Book Today!"
        static let bioTap: String = "Tap for bio"
        static let swipe: String = "Swipe!"

    }

    // MARK: SideDrawer

    enum SideDrawer {

        static let iconSize: CGFloat = 33
        static let fontSize: CGFloat = 25
        // Yellow
        static let buttonStartColor: Color = Color(red: 0.957, green: 0.698, blue: 0.243)
        // Orange
        static let buttonEndColor: Color = Color(red: 0.933, green: 0.427, blue: 0.176)
        static let cornerRadius: CGFloat = 15

        static let spaceRentalText: String = NSLocalizedString(
            "Space Rental",
            comment: "Space rental button text"
        )
        static let spaceRentalImage: String = NSLocalizedString(
            "house.fill",
            comment: "Space rental button image"
        )

        static let joinNowText: String = NSLocalizedString(
            "Join Now!",
            comment: "join now button text"
        )
        static let joinNowImage: String = NSLocalizedString(
            "person.crop.circle.badge.plus",
            comment: "Join now button image"
        )

        static let aboutText: String = NSLocalizedString(
            "About Us",
            comment: "about button text"
        )
        static let aboutImage: String = NSLocalizedString(
            "info.circle",
            comment: "About button image"
        )

        static let faqText: String = NSLocalizedString(
            "Newcomers / FAQ",
            comment: "faq button text"
        )
        static let faqImage: String = NSLocalizedString(
            "questionmark.circle",
            comment: "FAQ button image"
        )

        static let classesText: String = NSLocalizedString(
            "Classes",
            comment: "classes button text"
        )
        static let classesImage: String = NSLocalizedString(
            "calendar",
            comment: "Classes button image"
        )

        static let massageText: String = NSLocalizedString(
            "Massage Services",
            comment: "massage button text"
        )
        static let massageImage: String = NSLocalizedString(
            "hands.sparkles",
            comment: "Massage button image"
        )

        static let instagramLogo: String = NSLocalizedString(
            "InstagramLogo",
            comment: "Instagram logo image"
        )
        static let facebookLogo: String = NSLocalizedString(
            "FacebookLogo",
            comment: "Facebook logo image"
        )

        static let contactText: String = NSLocalizedString(
            "Contact us!",
            comment: "Contact text"
        )
        static let contactImage: String = NSLocalizedString(
            "envelope.badge",
            comment: "Contact button image"
        )

        static let contactFontSize: CGFloat = 20
        static let companyNameFontSize: CGFloat = 12
        static let contactImageSize: CGFloat = 4
        static let startRadius: CGFloat = 40
        static let endRadius: CGFloat = 400
        static let backgroundOpacity: Double = 0.6
        static let animationDuration: Double = 0.33
        static let frameWidth: CGFloat = 300
        static let buttonSpacing: CGFloat = 50
        static let outerCircleColorRadius: Color = Color(red: 0.0, green: 0.9, blue: 0.94)
        static let innerCircleColorRadius: Color = Color(red: 0.967, green: 0.698, blue: 0.243)
        static let buttonPressOpacity: CGFloat = 0.5
        static let buttonPressScale: CGFloat = 0.9
        static let sideDrawerButtonImageSize: CGFloat = 20
    }

    // MARK: Space Rental

    enum SpaceRental {

        static let amenities = [
            ("Three available spaces of varying sizes dependent upon scheduling", "🏢"),
            ("Tables, chairs, tablecloths, whiteboards, speakers, projectors", "🪑"),
            ("Convenient location & easy parking, with many nearby amenities", "🚗"),
            ("Includes usage of 1,890 sf room, 1366 sf room, or 668 sf room", "📐")
        ]

        static let privateEvents = [
            ("Wedding-related events", "👰"),
            ("Birthday parties", "🎂"),
            ("Team building & other corporate events", "🤝"),
            ("Special occasion nights with friends", "🎉"),
            ("Any reason to party!", "🎊")
        ]

        static let spaceRental = [
            ("Board meetings", "🎯"),
            ("Trainings", "💫"),
            ("Classes", "🎓"),
            ("Clubs and groups", "👥"),
            ("Corporate retreats", "🌟"),
            ("Practice space", "🎭")
        ]

        static let spaceImages = [
            "SpaceRental1",
            "SpaceRental2",
            "SpaceRental3",
            "SpaceRental4"
        ]

        static let pageTitle: String = "Private Events & Space Rental"
        static let pageBio: String = "If you can dream it, we can help you achieve it!"
        static let buttonText: String = "Inquire Today!"
        static let inquireTodayTitleText: String = "Competitive pricing! Contact Hilary at"
        static let contact: String = "hilary@bodypositivedancefitness.com"
        static let expandableButton1Text: String = "Venue Amenities"
        static let expandableButton2Text: String = "Private Events"
        static let expandableButton3Text: String = "General Space Rental"
    }
}
