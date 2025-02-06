//
//  ClassesView.swift
//  ClassesUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct DanceClassCard: View {
    var danceClass: DanceClass
    
    var body: some View {
        VStack {
            Text(danceClass.rawValue)
                .font(.system(size: 30, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Button(action: {
                if let url = URL(string: "https://www.bodypositivedancefitness.com/join-now-1") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Join Now!")
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                    .foregroundColor(.black)
                    .frame(width: 222, height: 44)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
            .padding(.top, 35)
            .padding(.bottom, 15)
        }
        .frame(width: 250, height: 250)
        .background(
            RadialGradient(
                gradient: Gradient(colors: [
                    danceClass.color.opacity(0.01),
                    danceClass.color.opacity(0.22)
                ]),
                center: .center, startRadius: 77, endRadius: 111
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(danceClass.color, lineWidth: 2)
        )
        .cornerRadius(15)
        .shadow(color: danceClass.color.opacity(0.8), radius: 30, x: 0, y: 0)
        .shadow(color: danceClass.color.opacity(0.4), radius: 40, x: 0, y: 0)
    }
}

struct ClassesView: View {
    @State var viewState = SwipableCarouselViewState(
        items: DanceClass.allCases,
        spacing: 10,
        sideSpacing: 60
    )
    
    // State that tracks whether the bio is visible.
    @State private var isBioExpanded: Bool = false
    
    // Compute the current dance class safely.
    var currentDanceClass: DanceClass {
        guard !viewState.items.isEmpty else {
            fatalError("No dance classes available.")
        }
        let count = viewState.items.count
        let safeIndex = ((viewState.currentIndex % count) + count) % count
        return viewState.items[safeIndex]
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Use a frame height equal to the tile’s height.
            SwipableCarouselComponent<AnyView, DanceClass>(
                viewModel: SwipableCarouselViewModel(viewState: $viewState)
            ) { danceClass, isCurrentCard in
                AnyView(
                    DanceClassCard(danceClass: danceClass)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isCurrentCard ? danceClass.color : Color.clear,
                                        lineWidth: isCurrentCard ? 3 : 0)
                        )
                        .shadow(
                            color: isCurrentCard ? danceClass.color.opacity(0.8) : Color.clear,
                            radius: 40, x: 0, y: 0
                        )
                        .shadow(
                            color: isCurrentCard ? danceClass.color.opacity(0.6) : Color.clear,
                            radius: 50, x: 0, y: 0
                        )
                )
            }
            .frame(height: 250)  // Adjusted to match the tile’s height
            
            // The button now sits immediately below the carousel tile.
            Button(action: {
                withAnimation(.easeInOut) {
                    isBioExpanded.toggle()
                }
            }) {
                HStack(spacing: 4) {
                    Text(isBioExpanded ? "Show Less" : "Learn More!")
                        .font(.system(size: 14, weight: .semibold, design: .serif))
                    Image(systemName: isBioExpanded ? "chevron.up" : "chevron.down")
                }
                .foregroundColor(.blue)
                .padding(.vertical, 8)
            }
            
            // Conditionally show the bio text.
            if isBioExpanded {
                Text(currentDanceClass.description)
                    .font(.system(size: 14, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

enum DanceClass: String, CaseIterable, Identifiable {
    case zumbaGold = "Zumba Gold®"
    case teal = "Teal"
    case orange = "Orange"
    case shineDance = "SHiNE Dance Fitness™"
    case africanHipHop = "African Hip Hop"
    case oula = "Oula"
    case uplift = "Uplift"
    case shineLight = "SHiNE LIGHT"
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .zumbaGold: return Color(red: 0.85, green: 0.65, blue: 0.13)
        case .teal: return Constants.Colors.neonCyan
        case .orange: return .orange
        case .shineDance: return Color(red: 1.0, green: 0.0, blue: 0.5)
        case .africanHipHop: return Color(red: 0.22, green: 1.0, blue: 0.08)
        case .oula: return Color(red: 0.90, green: 0.72, blue: 0.78)
        case .uplift: return Color(red: 0.63, green: 0.91, blue: 0.90)
        case .shineLight: return Color(red: 1.0, green: 1.0, blue: 0.0)
        }
    }
    
    var description: String {
        switch self {
        case .zumbaGold:
            return "Perfect for students who are looking for a modified Zumba® class that recreates the original moves you love at a lower intensity. The design of the class introduces easy-to-follow Zumba® choreography that focuses on balance, range of motion, and coordination. The class focuses on all elements of fitness: cardiovascular, muscular conditioning, flexibility and balance!"
        case .teal:
            return "Great for beginners and experienced dancers alike. Teal classes are slightly less complex and instructors do more distinct signaling to help dancers catch on quickly. They're designed for anyone who wants a fun and friendly way to hit the dance floor. With choreography that's consistent and intensity that's just right, these sessions are a favorite of new and seasoned dancers alike. Perfect for those who appreciate familiarity and comfort without sacrificing style."
        case .orange:
            return "Step up the pace with our Orange Zumba classes, designed for those who crave a little more zest in their fitness routine. Prepare to enter the cardio zone and let the rhythm take control. Get ready to unleash your inner diva and dance like no one's watching! Each week brings new surprises with an ever-changing playlist that ensures your dance experience stays fresh and exciting. While we notch up the complexity slightly, our instructors ensure the choreography remains accessible, delivering a balanced challenge that both delights and empowers. Beginners welcome - no experience required or expected!"
        case .shineDance:
            return "SHiNE Dance Fitness brings original routines to life using hit music and choreography for all abilities. Rooted in jazz, ballet, and hip-hop, this workout gives you a creative outlet to escape from daily stress. Each class includes the perfect balance of high cardio and toning to ensure you receive a full-body workout with real results. SHiNE is a mood-lifting experience that leaves you feeling capable, confident, and connected to a supportive community."
        case .africanHipHop:
            return "Whether you’re a seasoned pro or have two left feet, our classes are designed to get everyone moving, smiling, and sweating to the beat of the most electrifying music from Africa and beyond. No experience? No problem! Indulge in a unique blend of hip hop African dance and dancehall. Fun and energetic atmosphere guaranteed! Embrace diversity through dance – all are welcome!"
        case .oula:
            return "Oula merges high-intensity cardio with easy-to-follow choreography, mindfulness practices, and a culture of inclusivity — all to an energetic pop soundtrack. Every Oula class empowers participants to challenge their bodies and process their emotions through music, movement, and, most importantly, a community connection."
        case .uplift:
            return "SHiNE Dance Fitness™ has cracked the code to create a strength-training program that’s the perfect balance of effective and HELLA FUN! This is not a dance class, but each routine is choreographed to iconic music, and when safety isn’t compromised, you’re likely to find a booty shake or shimmy. A 1-hour UPLIFT class starts with a cardio warm-up and transitions to standing routines with equipment, alternating between upper and lower body. We complete the workout with routines for the core, booty, abs, and chest and a cool down with deep stretching. This UPLIFTING experience leaves you feeling strong and confident."
        case .shineLight:
            return "SHiNE LIGHT is a branch of SHiNE Dance Fitness specializing in low-impact and simplified choreography. SHiNE LIGHT uses all the same routines you find in SHiNE, but we reduce impact, increase stability and modify the moves to meet your needs as a student. It’s a mood-lifting, confidence-boosting experience for anyone looking for a more inclusive approach to dance fitness. We believe everyone deserves the FUN that dance provides. Join us! It’s your time to SHiNE!"
        }
    }
}


    




