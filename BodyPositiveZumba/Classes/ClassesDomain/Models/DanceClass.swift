//
//  DanceClass.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/6/25.
//

import Foundation
import SwiftUI

enum DanceClass: String, CaseIterable, Identifiable {
    case zumba = "Zumba®"
    case africanHipHop = "African Hip Hop"
    case shineLight = "SHiNE LIGHT"
    case strongNation = "STRONG Nation™"
    case yoga = "Yoga"
    case teal = "Teal"
    case orange = "Orange"
    case oula = "Oula"
    case uplift = "Uplift"
    case dark = "Dance After Dark"
    case shineDance = "SHiNE Dance Fitness™"
    case zumbaGold = "Zumba Gold®"

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .zumba: return Color(red: 1.0, green: 0.1, blue: 0.1)
        case .zumbaGold: return Color(red: 0.85, green: 0.65, blue: 0.13)
        case .yoga: return Color(red: 0.65, green: 0.8, blue: 0.55)
        case .africanHipHop: return Color(red: 0.22, green: 1.0, blue: 0.08)
        case .teal: return Constants.Colors.neonCyan
        case .orange: return .orange
        case .shineDance: return Color(red: 1.0, green: 0.0, blue: 0.5)
        case .strongNation: return Color(red: 0.1, green: 0.8, blue: 1.0)
        case .oula: return Color(red: 0.90, green: 0.72, blue: 0.78)
        case .uplift: return Color(red: 0.63, green: 0.91, blue: 0.90)
        case .dark: return Color(red: 0.7, green: 0.1, blue: 1.0)
        case .shineLight: return Color(red: 1.0, green: 1.0, blue: 0.0)
        }
    }

    var description: String {
        switch self {
        case .zumba:
            return "Zumba® brings people together through group exercise classes that blend rhythmic Latin music with high-intensity cardio dance moves to make getting in shape more fun than ever. Get a full-body workout while forgetting you're even exercising by joining the Zumba® dance party!"
        case .zumbaGold:
            return "Perfect for students who are looking for a modified Zumba® class that recreates the original moves you love at a lower intensity. The design of the class introduces easy-to-follow Zumba® choreography that focuses on balance, range of motion, and coordination. The class focuses on all elements of fitness: cardiovascular, muscular conditioning, flexibility and balance!"
        case .africanHipHop:
            return "Whether you’re a seasoned pro or have two left feet, our classes are designed to get everyone moving, smiling, and sweating to the beat of the most electrifying music from Africa and beyond. No experience? No problem! Indulge in a unique blend of hip hop African dance and dancehall. Fun and energetic atmosphere guaranteed! Embrace diversity through dance – all are welcome!"
        case .yoga:
            return " Our gentle yoga program is the perfect complement to a regular dance fitness routine, or for anyone looking to stretch, relax, and rejuvenate their body after an invigorating dance fitness class - or anytime! "
        case .teal:
            return "Great for beginners and experienced dancers alike. Teal classes are slightly less complex and instructors do more distinct signaling to help dancers catch on quickly. They're designed for anyone who wants a fun and friendly way to hit the dance floor. With choreography that's consistent and intensity that's just right, these sessions are a favorite of new and seasoned dancers alike. Perfect for those who appreciate familiarity and comfort without sacrificing style."
        case .orange:
            return "Step up the pace with our Orange Zumba classes, designed for those who crave a little more zest in their fitness routine. Prepare to enter the cardio zone and let the rhythm take control. Get ready to unleash your inner diva and dance like no one's watching! Each week brings new surprises with an ever-changing playlist that ensures your dance experience stays fresh and exciting. While we notch up the complexity slightly, our instructors ensure the choreography remains accessible, delivering a balanced challenge that both delights and empowers. Beginners welcome - no experience required or expected!"
        case .shineDance:
            return "SHiNE Dance Fitness brings original routines to life using hit music and choreography for all abilities. Rooted in jazz, ballet, and hip-hop, this workout gives you a creative outlet to escape from daily stress. Each class includes the perfect balance of high cardio and toning to ensure you receive a full-body workout with real results. SHiNE is a mood-lifting experience that leaves you feeling capable, confident, and connected to a supportive community."
        case .strongNation:
            return "STRONG Nation™ is a 45-minute bodyweight strength training class designed to accommodate all ages and fitness levels with modifications. While it’s not dance fitness, the moves are synced to original music to provide a fun and motivating fitness experience. We strongly believe that strength and health come in all shapes, sizes, and ages, and this class will help you celebrate your body for all it can do. "
        case .oula:
            return "Oula merges high-intensity cardio with easy-to-follow choreography, mindfulness practices, and a culture of inclusivity — all to an energetic pop soundtrack. Every Oula class empowers participants to challenge their bodies and process their emotions through music, movement, and, most importantly, a community connection."
        case .uplift:
            return "SHiNE Dance Fitness™ has cracked the code to create a strength-training program that’s the perfect balance of effective and HELLA FUN! This is not a dance class, but each routine is choreographed to iconic music, and when safety isn’t compromised, you’re likely to find a booty shake or shimmy. A 1-hour UPLIFT class starts with a cardio warm-up and transitions to standing routines with equipment, alternating between upper and lower body. We complete the workout with routines for the core, booty, abs, and chest and a cool down with deep stretching. This UPLIFTING experience leaves you feeling strong and confident."
        case .dark:
            return "We invite you to lose yourself in the music with easy-to-follow hip hop routines. You’ll discover confidence in your body, confidence on the dance floor, low impact, high sass, and freedom to be you! "

        case .shineLight:
            return "SHiNE LIGHT is a branch of SHiNE Dance Fitness specializing in low-impact and simplified choreography. SHiNE LIGHT uses all the same routines you find in SHiNE, but we reduce impact, increase stability and modify the moves to meet your needs as a student. It’s a mood-lifting, confidence-boosting experience for anyone looking for a more inclusive approach to dance fitness. We believe everyone deserves the FUN that dance provides. Join us! It’s your time to SHiNE!"
        }
    }
}
