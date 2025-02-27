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

    // MARK: About

    enum About {

        static let pageHeader: String = "About "
        static let pageTitle: String = "Body Positive Dance Fitness"
        static let pageBio: String = "The happiest workout in Maine™!"
        static let button1Title: String = "Who are we?"
        static let button2Title: String = "What do we do?"
        static let button1Content: String = "At Body Positive Dance Fitness, everyone is welcome - dance experience or a self-concept of being 'coordinated' not required. We're here to celebrate you for who you are - right now! Our goal is to have fun - together - and our only expectation is that everyone is treated with kindness, dignity and respect. \n\nWe offer classes every day, multiple times per day, so that students can enjoy classes that fit their schedules and exercise routines.\n\nOf course it's not just our instructors and our class types that make Body Positive so special...  \n\nWhat truly distinguishes Body Positive is our physical space. This studio is a community hub for participants all over Maine and New England who have a place to call their own, where their style of exercise and community spirit is the central focus of the location."
        static let button2Content: String = " At Body Positive Dance Fitness, students of all levels revel in the experience of dancing to great music among a welcoming community that shares a joy for dancing as a way to exercise. Unlike other workouts, dance fitness is a cardiovascular workout that is distinct because it’s actually fun! The experience of dancing together unites people in a social context unlike any typical gym experience. \n\nAt BPDF, all body types and levels of experience and ability are welcome — we are here to have fun, not to train professional dancers. Students have a home base where they can exercise on their schedules at the times that work for them.  Our students even have the flexibility to attend multiple classes a day without disrupting their competing priorities.At Body Positive Dance Fitness, we unite students from all over with the highest quality teachers in the Greater Portland area. Each of our instructors has a unique style that resonates with a variety of students at different fitness levels.\n\nOur dance fitness class styles vary as well. Our core offering is Zumba, the largest most successful dance fitness format in the world with over five million participants a day. Zumba’s format allows instructors freedom and creativity to choreograph songs of their choice generally using Latin dance formats as a base. As a result, no two Zumba classes or instructors are alike, except that participants all learn the basic steps, moves and rhythms. We offer other formats as well – some based in ballet, hip hop and pop (such as SHiNE), others based in music from the 70s, 80s and 90s (such as HotFlash) and still others varying in complexity from basic fitness moves to fully developed choreography. \n\nAt BPDF, all body types and levels of experience and ability are welcome — we are here to have fun!"
        static let mediaTitle: String = "Media!"
        static let mediaURL: String = "https://www.bodypositivedancefitness.com/media-news"
        static let whatPageTitle: String = "What Do We Do?"
        static let whoPageTitle: String = "Who Are We?"

        static let actionButton1: String = "team"
        static let actionButton2: String = "classes"
        static let actionButton3: String = "partners"
        static let actionButton4: String = "media"

    }

    // MARK: Classes

    enum Classes {

        static let pageTitle: String = "Classes"
        static let pageBioPt1: String = "Explore our "
        static let pageBioPt2: String = "Colors"
        static let pageBioPt3: String = " below!"
        static let viewAllButtonText: String = "View All Classes"
        static let viewCalendarButtonText: String = "View Calendar"
        static let closeButtonText: String = "Show Less"
        static let openButtonText: String = "Learn More About "
        static let joinNowButtonText: String = "Join Now!"
        static let viewCalendarUrl: String = "https://www.bodypositivedancefitness.com/calendar"

        static let bookNowWebviewTitle: String = "Book A Class"
        static let viewAllClassesPageTitle: String = "All Classes"
        static let bookButtonText: String = "Book!"
    }

    // MARK: Colors

    enum Colors {

        static let rainbow: [Color] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple,
            .pink
        ]
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

        static let youtubeLink: String = NSLocalizedString(
            "https://www.youtube.com/@bodypositivedancefitness",
            comment: "yt link")

        static let tradeMarkSlogan: String = NSLocalizedString(
            "Are You Ready For The Happiest Workout In Maine?™",
            comment: "trademarked slogan")

        static let logoName: String = NSLocalizedString(
            "BodyPositiveLogo",
            comment: "string file name")

        static let companyName: String = NSLocalizedString(
            "© Body Positive Dance Fitness LLC 2023",
            comment: "company name")

        static let companyAddress: String = "1100 Brighton Avenue Pine Tree Shopping Center Portland, Maine"
        static let companyPhone: String = "207-536-4617"
        static let companyEmail: String = "dancing@bodypositivedancefitness.com"

    }

    // MARK: Contact

    enum Contact {

        static let pageTitle: String = "Please Reach Out\nAnytime!"
        static let pageBio: String = "We're here to help and listen"

        static let contactRows: [ContactRowData] = [

            ContactRowData(
                title: "Message us!",
                icon: "bubble.left.and.bubble.right.fill",
                text: "Send us a message",
                action: "https://www.bodypositivedancefitness.com/contact-1",
                iconColor: Color.blue
            ),
            ContactRowData(
                title: "Call us!",
                icon: "phone.fill",
                text: "207-536-4617",
                action: "tel://207-536-4617",
                iconColor: Color.green
            ),
            ContactRowData(
                title: "Email us!",
                icon: "envelope.open.fill",
                text: "dancing@bodypositivedancefitness.com",
                action: "mailto:dancing@bodypositivedancefitness.com",
                iconColor: Color.purple
            ),
            ContactRowData(
                title: "Visit us!",
                icon: "mappin.and.ellipse",
                text: "1100 Brighton Avenue Pine Tree Shopping Center Portland, Maine",
                action: "https://www.google.com/maps/place/1100+Brighton+Ave,+Portland,+ME+04102/@43.6751784,-70.3277432,17z/data=!3m1!4b1!4m6!3m5!1s0x4cb29a4b628bb81b:0x89e493444035762a!8m2!3d43.6751784!4d-70.3251683!16s%2Fg%2F11b8v4s1lm?entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
                iconColor: Color.red
            )
        ]

        static let innerGradient: Color = Constants.SideDrawer.innerCircleColorRadius.opacity(0.2)
        static let outerGradient: Color = Constants.SideDrawer.outerCircleColorRadius.opacity(0.2)
        static let startRadius: CGFloat = 35
        static let endRadius: CGFloat = 400
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
        static let chevron = "chevron.right"
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
            "Welcome to",
            comment: "home screen greeting message"
        )
        static let pageBio: String = "and welcome to"
        static let bookClassesButton: String = "Book A Class!"
        static let viewClassesButton: String = "View Classes"
        static let viewPassesButton: String = "Explore Passes"
        static let aboutButton: String = "About Us!"
        static let exploreButton: String = "Explore More!"
        static let photosButton: String = "View Photos"
        static let passesBio: String = "save money - purchase a pass!"
        static let tradeMarkSloganSize: CGFloat = 22
        static let proxy = "topContent"

        static let images: [String] = [
            "Home1",
            "Home2",
            "Home3",
            "Home4",
            "Home5",
            "Home6"
        ]
    }

    // MARK: Join Now

    enum JoinNow {

        static let joinNowUrl: String = "https://bodypositive.punchpass.com/classes"
        static let passesUrl: String = "https://bodypositive.punchpass.com/passes"
        static let joinNowTitle: String = "Join Us!"
        static let passesTitle: String = "View Passes"
    }

    // MARK: Maintenance

    enum Maintenance {

        static let pageTitle: String = "Hang Tight!"
        static let pageBio: String = "Big things are happening behind the scenes at BodyPositiveDanceFitness!\nWe're working hard to bring you an even more amazing experience.\nThank you for your patience!"
        static let blockTitle: String = "In the meantime, you can:"
        static let visit: String = "Visit us:"
        static let call: String = "Call us:"
        static let email: String = "Email us"
    }

    // MARK: Massage

    enum Massage {
        static let pageTitle: String = "Massage Services"
        static let pageBio: String = "Partnering with Lindsey (Lady Love Holistics) and Shelby (Swann's Healing Elements), we now offer sports massage, therapy, health coaching, and Reiki for our members and community!"

        static let LindseyHerseyParlor: String = "Lady Love Holistics"
        static let ShelbySwannParlor: String = "Swann's Healing Elements"
        static let LindseyHerseyBio: String = "Lindsey is an experienced massage therapist who specializes in sports massage, health coaching, and Reiki."
        static let ShelbySwannBio: String = "Shelby is a skilled massage therapist offering a range of healing techniques, including Reiki and massage therapy."
        static let LindseyHerseyFirstName: String = "Lindsey"
        static let ShelbySwannFirstName: String = "Shelby"
        static let ladyLoveHolisticURL: String = "https://ladyloveholistics.com/"
        static let swannsHealingElementsURL: String = "https://swanns-healing-elements.square.site/"

        static let buttonText: String = "Book Today!"
        static let bioTap: String = "Tap card for bio"
        static let swipe: String = "Swipe!"

        static let cards: [MassageCardModel] = [
            MassageCardModel(
                id: UUID(),
                fullName: Constants.HeadShots.LindseyHerseyName,
                firstName: Constants.Massage.LindseyHerseyFirstName,
                imageName: Constants.HeadShots.LindseyHerseyHeadShot,
                parlor: Constants.Massage.LindseyHerseyParlor,
                bio: Constants.Massage.LindseyHerseyBio
            ),
            MassageCardModel(
                id: UUID(),
                fullName: Constants.HeadShots.ShelbySwannName,
                firstName: Constants.Massage.ShelbySwannFirstName,
                imageName: Constants.HeadShots.ShelbySwannHeadShot,
                parlor: Constants.Massage.ShelbySwannParlor,
                bio: Constants.Massage.ShelbySwannBio
            )
        ]

    }

    // MARK: Partners

    enum Partners {

        static let pageTitle: String = "Partners"
        static let buttonText: String = "Visit Website"
        static let pageBio: String = "Explore our amazing partners below!"
    }

    // MARK: SideDrawer

    enum SideDrawer {

        static let fontSize: CGFloat = 24
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
            "building.2.fill",
            comment: "Space rental button image"
        )

        static let joinNowText: String = NSLocalizedString(
            "Join or Book!",
            comment: "join now button text"
        )
        static let joinNowImage: String = NSLocalizedString(
            "calendar.badge.plus",
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

        static let youtubeLogo: String = NSLocalizedString(
            "YouTubeLogo",
            comment: "Youtube logo image"
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
        static let buttonSpacing: CGFloat = 53
        static let outerCircleColorRadius: Color = Color(red: 0.0, green: 0.9, blue: 0.94)
        static let innerCircleColorRadius: Color = Color(red: 0.967, green: 0.698, blue: 0.243)
        static let buttonPressOpacity: CGFloat = 0.5
        static let buttonPressScale: CGFloat = 0.9
        static let sideDrawerButtonImageSize: CGFloat = 25
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

    enum Team {

        static let teamPageTitle: String = "Meet The Team!"

        // Carson Burnham
        static let CarsonBurnhamImage: String = "CarsonBurnhamHeadShot"
        static let CarsonBurnhamName: String = "Carson Burnham"
        static let CarsonBurnhamRole: String = "Owner / Instructor"
        static let CarsonBurnhamBio: String = "Carson loves dance fitness because it reminds her of when she and her sister were little kids, making up routines to records. She’s been doing dance fitness since the days of aerobics with Jane Fonda, and believes it’s the only kind of exercise that’s actually fun. This is the style she brings to her classes – she believes that playlists should have songs that make you want to sing along and engage with the music, and she encourages participants to let loose and be silly. Carson’s playlists include enough high intensity songs so that you get a great workout every time, but she designs them in an interval style so you can feel strong and able to keep going for as long as you like. If you want to take a class where the moves are always accessible and you never have to worry about whether you look like “a dancer,” check out Carson’s class – it’s true No Pressure Dancing!"
        static let CarsonBurnhamFirstName: String = "Carson"

        // Erin Evans
        static let ErinEvansImage: String = "ErinEvansHeadShot"
        static let ErinEvansName: String = "Erin Evans"
        static let ErinEvansRole: String = "Owner / Instructor"
        static let ErinEvansBio: String = "Erin approaches teaching from the perspective of a longtime Zumba student. She loves fun songs and easy-to-follow choreography that make you forget you are getting a great workout and leave you wondering how the hour passed so quickly!"
        static let ErinEvansFirstName: String = "Erin"

        // Beth Abramson
        static let BethAbramsonImage: String = "BethAbramsonHeadShot"
        static let BethAbramsonName: String = "Beth Abramson"
        static let BethAbramsonRole: String = "Instructor"
        static let BethAbramsonBio: String = "In Beth’s classes, you can expect a high energy workout with fun, easy to follow choreography. She creates a welcoming space where you can dance and let loose! Beth enjoys the spice of traditional Latin rhythms but you can expect to dance to all genres of music! Get ready for a full hour of pure dance party fun!"
        static let BethAbramsonFirstName: String = "Beth"

        // Amy Bates
        static let AmyBatesImage: String = "AmyBatesHeadShot"
        static let AmyBatesName: String = "Amy Bates"
        static let AmyBatesRole: String = "Instructor"
        static let AmyBatesBio: String = "Amy found dance fitness quite unexpectedly – she was walking by Mallory’s SHiNE class, saw people having a great time, and wanted a piece of that! Since then, she has become a SHiNE devotee, eventually getting certified as a SHiNE instructor. She loves sharing SHiNE with students, so look for her in pink and say hello!"
        static let AmyBatesFirstName: String = "Amy"

        // Meredith Bolton
        static let MeredithBoltonImage: String = "MeredithBoltonHeadShot"
        static let MeredithBoltonName: String = "Meredith Bolton"
        static let MeredithBoltonRole: String = "Instructor"
        static let MeredithBoltonBio: String = "Meredith loves letting loose and dancing to a good beat, and finds SHiNE™ fun and engaging. Meredith believes that everyone can dance - that no one moves and dances like you - and that's great! Her hope is to share with others what she has gained from SHiNE - confidence, freedom of self-expression, strength, and a supportive, uplifting community."
        static let MeredithBoltonFirstName: String = "Meredith"

        // Logan Burnham
        static let LoganBurnhamImage: String = "LoganBurnhamHeadShot"
        static let LoganBurnhamName: String = "Logan Burnham"
        static let LoganBurnhamRole: String = "Staff"
        static let LoganBurnhamBio: String = "Logan is a member of the front desk crew and is an aspiring novelist and video game nerd. He’s happy to chatter away about nothing of import and keeping it silly is very important to him. Make sure you say hi next time you see him!"
        static let LoganBurnhamFirstName: String = "Logan"

        // Patty Cook
        static let PattyCookImage: String = "PattyCookHeadShot"
        static let PattyCookName: String = "Patty Cook"
        static let PattyCookRole: String = "Instructor"
        static let PattyCookBio: String = "Patty creates a warm and welcoming atmosphere where students can feel at home and experience a great Zumba workout. She loves getting to know her students, and puts a lot of fun and energy into her classes, so you will leave with a good sweat and a great smile!"
        static let PattyCookFirstName: String = "Patty"

        // Hilary Deuben
        static let HilaryDeubenImage: String = "HilaryDeubenHeadShot"
        static let HilaryDeubenName: String = "Hilary Deuben"
        static let HilaryDeubenRole: String = "Director of Operations"
        static let HilaryDeubenBio: String = "Hilary has worked as an organizer for 15 years. She is passionate about building and supporting small local businesses. Since taking her first dance fitness class in October of 2023, she has become a staunch supporter of joyful movement in supportive & inclusive group settings. She loves that Body Positive Dance Fitness fosters healthy bodies, minds and a sense of community."
        static let HilaryDeubenFirstName: String = "Hilary"

        // Alison Doucette
        static let AlisonDoucetteImage: String = "AlisonDoucetteHeadShot"
        static let AlisonDoucetteName: String = "Alison Doucette"
        static let AlisonDoucetteRole: String = "Instructor"
        static let AlisonDoucetteBio: String = "Alison believes Zumba should be a place to let down your hair and have some fun. Her class is full of easy-going fun, laughs and great community! Remember, it's not a mistake, just a solo!"
        static let AlisonDoucetteFirstName: String = "Alison"

        // Cholla Foote
        static let ChollaFooteImage: String = "ChollaFooteHeadShot"
        static let ChollaFooteName: String = "Cholla Foote"
        static let ChollaFooteRole: String = "Instructor"
        static let ChollaFooteBio: String = "Cholla believes that movement is medicine from the soul and offers a judgment free zone to experience whatever YOU need to. Oula been called dance therapy, feelings fitness and a living room dance party -- you decide!"
        static let ChollaFooteFirstName: String = "Cholla"

        // Kendra
        static let KendraImage: String = "KendraHeadShot"
        static let KendraName: String = "Kendra"
        static let KendraRole: String = "Staff"
        static let KendraBio: String = "Kendra is a member of the front desk crew and has been enjoying that role since BPDF opened! She loves dancing as much as she loves warmly greeting every person who comes through the studio doors. Body Positive’s joyful, uplifting environment is a perfect complement to her work as a local nurse and educator. Stick around long enough and you’ll see her on the dance floor too!"
        static let KendraFirstName: String = "Kendra"

        // Erin Gallagher
        static let ErinGallagherImage: String = "ErinGallagherHeadShot"
        static let ErinGallagherName: String = "Erin Gallagher"
        static let ErinGallagherRole: String = "Instructor"
        static let ErinGallagherBio: String = "Erin absolutely loves dancing with people, putting a smile on their faces and a little shake in their booties. Her high-intensity classes will leave you with a great sweat! Erin recently moved to Maine this May and is so excited to have found her new community in Zumba."
        static let ErinGallagherFirstName: String = "Erin"

        // Claudia Getchell
        static let ClaudiaGetchellImage: String = "ClaudiaGetchellHeadShot"
        static let ClaudiaGetchellName: String = "Claudia Getchell"
        static let ClaudiaGetchellRole: String = "Staff"
        static let ClaudiaGetchellBio: String = "A few years ago, Claudia met an incredible group of fun women in a local Zumba class, and they became fast friends. When Erin and Carson later shared their vision for a dance fitness studio, Claudia was eager to support this dream and is proud to help them see it fulfilled. She loves the friendships that she has developed being a part of this amazing group of women, and loves being part of the BPDF team."
        static let ClaudiaGetchellFirstName: String = "Claudia"

        // Liz Hamp
        static let LizHampImage: String = "LizHampHeadShot"
        static let LizHampName: String = "Liz Hamp"
        static let LizHampRole: String = "Instructor"
        static let LizHampBio: String = "Liz wants every class she teaches to be fun, safe and welcoming. Whether you’re just getting started or a veteran, she wants everyone to leave feeling successful and happy that they came."
        static let LizHampFirstName: String = "Liz"

        // Lindsey Hersey
        static let LindseyHerseyImage: String = "LindseyHerseyHeadShot"
        static let LindseyHerseyName: String = "Lindsey Hersey"
        static let LindseyHerseyRole: String = "Instructor/Massage Therapist"
        static let LindseyHerseyBio: String = "Lindsey brings the energy to her high intensity Zumba classes! Her style is influenced by many cultures from across the world. Her class will have you celebrating what dance fitness is all about! Come join the party! Lindsey is also the owner of Lady Love Holistics, right here on the BPDF premises! She offers massage therapy, health coaching, and Reiki."
        static let LindseyHerseyFirstName: String = "Lindsey"

        // Barbara Kenney
        static let BarbaraKenneyImage: String = "BarbaraKenneyHeadShot"
        static let BarbaraKenneyName: String = "Barbara Kenney"
        static let BarbaraKenneyRole: String = "Instructor"
        static let BarbaraKenneyBio: String = "Barbara has decades of experience teaching dance, from ballroom to Zumba. She loves connecting with students in class and ensuring everyone has a good time and is taking care of their bodies. Her routines are easy to follow, you can turn the intensity up or down, and her music is so much fun!"
        static let BarbaraKenneyFirstName: String = "Barbara"

        // Jess Lamoureux
        static let JessLamoureuxImage: String = "JessLamoureuxHeadShot"
        static let JessLamoureuxName: String = "Jess Lamoureux"
        static let JessLamoureuxRole: String = "Instructor"
        static let JessLamoureuxBio: String = "Jess believes that every body is beautiful, and her medium-intensity classes are designed to make everyone feel welcome, regardless of age, size, shape, or ability. Her classes are a judgment-free environment where you can dance with confidence, joy, and maybe a little silliness!"
        static let JessLamoureuxFirstName: String = "Jess"

        // Sharon Levine
        static let SharonLevineImage: String = "SharonLevineHeadShot"
        static let SharonLevineName: String = "Sharon Levine"
        static let SharonLevineRole: String = "Staff"
        static let SharonLevineBio: String = "Sharon started taking dance lessons at the age of five and enjoyed every single one. Now, dancing is sweeter than ever because she gets to dance and connect with old and new friends at Body Positive. BPDF provides Sharon with “a welcoming, healthy lifestyle full of people who want to be the best physically and mentally that they have ever been. And of course, friendships that I never knew existed!”"
        static let SharonLevineFirstName: String = "Sharon"

        // Naomi Grace McNeill
        static let NaomiGraceMcNeillImage: String = "NaomiGraceMcNeillHeadShot"
        static let NaomiGraceMcNeillName: String = "Naomi Grace McNeill"
        static let NaomiGraceMcNeillRole: String = "Instructor"
        static let NaomiGraceMcNeillBio: String = "“The Swole Sisters” want you to feel awesome and capable from the first try. YOUR BODY, YOUR WORKOUT. Our mantra is \"We Dance! We sweat! We Laugh!\" They provide a high-intensity class geared towards lots of laughter and endorphins."
        static let NaomiGraceMcNeillFirstName: String = "Naomi Grace"

        // Mallory Lord
        static let MalloryLordImage: String = "MalloryLordHeadShot"
        static let MalloryLordName: String = "Mallory Lord"
        static let MalloryLordRole: String = "Instructor"
        static let MalloryLordBio: String = "Working out should never be boring! Mallory builds her playlist with a little sass and a whole lot of fun, so you can leave all your worries at the door. Mallory highly encourages twerking and her judgement-free class will leave you feeling confident, happy and just a little extra sassy!"
        static let MalloryLordFirstName: String = "Mallory"

        // Aubine Ntibandetse
        static let AubineNtibandetseImage: String = "AubineNtibandetseHeadShot"
        static let AubineNtibandetseName: String = "Aubine Ntibandetse"
        static let AubineNtibandetseRole: String = "Instructor"
        static let AubineNtibandetseBio: String = "African hip-hop is a class that brings people together and embraces everybody's uniqueness. Aubine’s class provides a safe place for self-expression, creativity, and learning. She believes that her wide music selection allows each and everyone to feel welcome. Her class is fun, hip, and stress-free!"
        static let AubineNtibandetseFirstName: String = "Aubine"

        // Andrea Meadows
        static let AndreaMeadowsImage: String = "AndreaMeadowsHeadShot"
        static let AndreaMeadowsName: String = "Andrea Meadows"
        static let AndreaMeadowsRole: String = "Instructor"
        static let AndreaMeadowsBio: String = "“The Swole Sisters” want you to feel awesome and capable from the first try. YOUR BODY, YOUR WORKOUT. Our mantra is \"We Dance! We sweat! We Laugh!\" They provide a high-intensity class geared towards lots of laughter and endorphins."
        static let AndreaMeadowsFirstName: String = "Andrea"

        // Jordan Peden
        static let JordanPedenImage: String = "JordanPedenHeadShot"
        static let JordanPedenName: String = "Jordan Peden"
        static let JordanPedenRole: String = "Social Media & Marketing Associate"
        static let JordanPedenBio: String = "Jordan is a writer and the Marketing and Social Media Associate for Body Positive Dance Fitness. Though she’d never attended a dance class before working for BPDF, you can now find her on the dance floor multiple days a week. Jordan loves spreading the word about BPDF and the joy of dance fitness because she’s experienced firsthand how this community teaches you to love yourself and let go of negativity. When she’s not posting on social media or writing community-centered articles for national and local publications, she enjoys spending time with her husband and daughter, enjoying outdoor activities, seeing live music, and, of course, DANCING!"
        static let JordanPedenFirstName: String = "Jordan"

        // Shelby Swann
        static let ShelbySwannImage: String = "ShelbySwannHeadShot"
        static let ShelbySwannName: String = "Shelby Swann"
        static let ShelbySwannRole: String = "Massage Therapist"
        static let ShelbySwannBio: String = "Shelby is one of BPDF’s on-site sports massage therapists. Shelby loves providing a healing space for people, and has incredible intuition and connection. She enjoys helping folks feel their best, and shares stretches with her clients that they can do in between massages. We are thrilled to have Shelby on board!"
        static let ShelbySwannFirstName: String = "Shelby"

        // Karrie Sweet
        static let KarrieSweetImage: String = "KarrieSweetHeadShot"
        static let KarrieSweetName: String = "Karrie Sweet"
        static let KarrieSweetRole: String = "Instructor"
        static let KarrieSweetBio: String = "Karrie Sweet first caught the SHiNE bug in 2017 and became an instructor this summer. Karrie believes the beauty of SHiNE is its ability to make you feel tough, sexy, and graceful all in one. Dance with Karrie and discover why fitness is fun!"
        static let KarrieSweetFirstName: String = "Karrie"

        // Meaghan Wildes
        static let MeaghanWildesImage: String = "MeaghanWildesHeadShot"
        static let MeaghanWildesName: String = "Meaghan Wildes"
        static let MeaghanWildesRole: String = "Instructor"
        static let MeaghanWildesBio: String = "Meaghan’s classes are fun, interactive, energetic, and made for all abilities! She will lead you from low intensity to high intensity and everywhere in between. Meaghan instructs with so much joy and happiness, you may find her dancing right next to you or cheering you on! Her playlists will bring you around the world, experiencing many Latin rhythms and more. Hooting, hollering, and getting loud are strongly encouraged in her class! You will laugh, smile, and sweat as you experience an hour of pure Zumba joy!"
        static let MeaghanWildesFirstName: String = "Meaghan"

        // Becky Woodford
        static let BeckyWoodfordImage: String = "BeckyWoodfordHeadShot"
        static let BeckyWoodfordName: String = "Becky Woodford"
        static let BeckyWoodfordRole: String = "Instructor"
        static let BeckyWoodfordBio: String = "Becky’s dance philosophy is “There are no mistakes, only solos!” The only rules in her class are to have fun and be safe. Her goal is that every participant leaves her class with a smiling, sweaty face. You choose the intensity according to what your body wants that day!"
        static let BeckyWoodfordFirstName: String = "Becky"

        static let cards: [TeamCardModel] = [
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.CarsonBurnhamName,
                imageName: Constants.Team.CarsonBurnhamImage,
                role: Constants.Team.CarsonBurnhamRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.ErinEvansName,
                imageName: Constants.Team.ErinEvansImage,
                role: Constants.Team.ErinEvansRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.BethAbramsonName,
                imageName: Constants.Team.BethAbramsonImage,
                role: Constants.Team.BethAbramsonRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.AmyBatesName,
                imageName: Constants.Team.AmyBatesImage,
                role: Constants.Team.AmyBatesRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.MeredithBoltonName,
                imageName: Constants.Team.MeredithBoltonImage,
                role: Constants.Team.MeredithBoltonRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.LoganBurnhamName,
                imageName: Constants.Team.LoganBurnhamImage,
                role: Constants.Team.LoganBurnhamRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.PattyCookName,
                imageName: Constants.Team.PattyCookImage,
                role: Constants.Team.PattyCookRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.HilaryDeubenName,
                imageName: Constants.Team.HilaryDeubenImage,
                role: Constants.Team.HilaryDeubenRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.AlisonDoucetteName,
                imageName: Constants.Team.AlisonDoucetteImage,
                role: Constants.Team.AlisonDoucetteRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.ChollaFooteName,
                imageName: Constants.Team.ChollaFooteImage,
                role: Constants.Team.ChollaFooteRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.KendraName,
                imageName: Constants.Team.KendraImage,
                role: Constants.Team.KendraRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.ErinGallagherName,
                imageName: Constants.Team.ErinGallagherImage,
                role: Constants.Team.ErinGallagherRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.ClaudiaGetchellName,
                imageName: Constants.Team.ClaudiaGetchellImage,
                role: Constants.Team.ClaudiaGetchellRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.LizHampName,
                imageName: Constants.Team.LizHampImage,
                role: Constants.Team.LizHampRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.LindseyHerseyName,
                imageName: Constants.Team.LindseyHerseyImage,
                role: Constants.Team.LindseyHerseyRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.BarbaraKenneyName,
                imageName: Constants.Team.BarbaraKenneyImage,
                role: Constants.Team.BarbaraKenneyRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.JessLamoureuxName,
                imageName: Constants.Team.JessLamoureuxImage,
                role: Constants.Team.JessLamoureuxRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.SharonLevineName,
                imageName: Constants.Team.SharonLevineImage,
                role: Constants.Team.SharonLevineRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.NaomiGraceMcNeillName,
                imageName: Constants.Team.NaomiGraceMcNeillImage,
                role: Constants.Team.NaomiGraceMcNeillRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.MalloryLordName,
                imageName: Constants.Team.MalloryLordImage,
                role: Constants.Team.MalloryLordRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.AubineNtibandetseName,
                imageName: Constants.Team.AubineNtibandetseImage,
                role: Constants.Team.AubineNtibandetseRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.AndreaMeadowsName,
                imageName: Constants.Team.AndreaMeadowsImage,
                role: Constants.Team.AndreaMeadowsRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.JordanPedenName,
                imageName: Constants.Team.JordanPedenImage,
                role: Constants.Team.JordanPedenRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.ShelbySwannName,
                imageName: Constants.Team.ShelbySwannImage,
                role: Constants.Team.ShelbySwannRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.KarrieSweetName,
                imageName: Constants.Team.KarrieSweetImage,
                role: Constants.Team.KarrieSweetRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.MeaghanWildesName,
                imageName: Constants.Team.MeaghanWildesImage,
                role: Constants.Team.MeaghanWildesRole
            ),
            TeamCardModel(
                id: UUID(),
                name: Constants.Team.BeckyWoodfordName,
                imageName: Constants.Team.BeckyWoodfordImage,
                role: Constants.Team.BeckyWoodfordRole
            )
        ]

        static let bios: [TeamBioModel] = [
            TeamBioModel(
                bio: Constants.Team.CarsonBurnhamBio,
                firstName: Constants.Team.CarsonBurnhamFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.ErinEvansBio,
                firstName: Constants.Team.ErinEvansFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.BethAbramsonBio,
                firstName: Constants.Team.BethAbramsonFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.AmyBatesBio,
                firstName: Constants.Team.AmyBatesFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.MeredithBoltonBio,
                firstName: Constants.Team.MeredithBoltonFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.LoganBurnhamBio,
                firstName: Constants.Team.LoganBurnhamFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.PattyCookBio,
                firstName: Constants.Team.PattyCookFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.HilaryDeubenBio,
                firstName: Constants.Team.HilaryDeubenFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.AlisonDoucetteBio,
                firstName: Constants.Team.AlisonDoucetteFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.ChollaFooteBio,
                firstName: Constants.Team.ChollaFooteFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.KendraBio,
                firstName: Constants.Team.KendraFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.ErinGallagherBio,
                firstName: Constants.Team.ErinGallagherFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.ClaudiaGetchellBio,
                firstName: Constants.Team.ClaudiaGetchellFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.LizHampBio,
                firstName: Constants.Team.LizHampFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.LindseyHerseyBio,
                firstName: Constants.Team.LindseyHerseyFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.BarbaraKenneyBio,
                firstName: Constants.Team.BarbaraKenneyFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.JessLamoureuxBio,
                firstName: Constants.Team.JessLamoureuxFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.SharonLevineBio,
                firstName: Constants.Team.SharonLevineFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.NaomiGraceMcNeillBio,
                firstName: Constants.Team.NaomiGraceMcNeillFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.MalloryLordBio,
                firstName: Constants.Team.MalloryLordFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.AubineNtibandetseBio,
                firstName: Constants.Team.AubineNtibandetseFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.AndreaMeadowsBio,
                firstName: Constants.Team.AndreaMeadowsFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.JordanPedenBio,
                firstName: Constants.Team.JordanPedenFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.ShelbySwannBio,
                firstName: Constants.Team.ShelbySwannFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.KarrieSweetBio,
                firstName: Constants.Team.KarrieSweetFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.MeaghanWildesBio,
                firstName: Constants.Team.MeaghanWildesFirstName
            ),
            TeamBioModel(
                bio: Constants.Team.BeckyWoodfordBio,
                firstName: Constants.Team.BeckyWoodfordFirstName
            )
        ]

    }
}
