//
//  SpaceRentalView.swift
//  SpaceRentalUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct AnimatedBulletPoint: View {
    let text: String
    let emoji: String
    @State private var isAnimating = false
    @State private var sparkleOpacity: Double = 0

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Text(emoji)
                    .font(.system(size: 20))
                    .opacity(sparkleOpacity)
                    .scaleEffect(isAnimating ? 1.2 : 0.8)
                Text(emoji)
                    .font(.system(size: 16))
                    .opacity(sparkleOpacity)
                    .scaleEffect(isAnimating ? 0.8 : 1.2)
            }
            .frame(width: 40, alignment: .leading)
            Text(text)
                .font(.system(size: 18, design: .serif))
                .foregroundColor(.black.opacity(0.8))
        }
        .padding(.vertical, 4)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                isAnimating.toggle()
                sparkleOpacity = 1
            }
        }
    }
}

struct ExpandableSection: View {
    let title: String
    let items: [(String, String)]
    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 12) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.4), value: isExpanded)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.orange.opacity(0.1),
                            Color.orange.opacity(0.7)
                        ]),
                        center: .center, startRadius: 8, endRadius: 88
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.cyan, lineWidth: 2)
                )
                .cornerRadius(10)
            }
            if isExpanded {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(items, id: \.0) { item in
                        AnimatedBulletPoint(text: item.0, emoji: item.1)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .transition(.scale.combined(with: .opacity))
            }
        }
    }
}

struct SpaceRentalView: View {
    @State private var showMessage = false

    private let amenities = [
        ("Three available spaces of varying sizes dependent upon scheduling", "✨"),
        ("Tables, chairs, tablecloths, whiteboards, speakers, projectors", "✨"),
        ("Convenient location & easy parking, with many nearby amenities", "✨"),
        ("Includes usage of 1,890 sf room, 1366 sf room, or 668 sf room", "✨")
    ]
    
    private let privateEvents = [
        ("Wedding-related events", "👰"),
        ("Birthday parties", "🎂"),
        ("Team building & other corporate events", "🤝"),
        ("Special occasion nights with friends", "🎉"),
        ("Any reason to party!", "🎊")
    ]
    
    private let spaceRental = [
        ("Board meetings", "🎯"),
        ("Trainings", "💫"),
        ("Classes", "🎓"),
        ("Clubs and groups", "👥"),
        ("Corporate retreats", "🌟"),
        ("Practice space", "🎭")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Private Events & Space Rental")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Text("If you can dream it, we can help you achieve it!")
                    .font(.system(size: 22, design: .serif))
                    .foregroundColor(.black.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                VStack(spacing: 10) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showMessage.toggle()
                        }
                    }) {
                        Text("Inquire Today!")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                RadialGradient(
                                    gradient: Gradient(colors: [
                                        Constants.Colors.neonCyan.opacity(0.1),
                                        Constants.Colors.neonCyan.opacity(0.5)
                                    ]),
                                    center: .center, startRadius: 8, endRadius: 88
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.orange, lineWidth: 2)
                            )
                            .cornerRadius(10)
                    }
                    if showMessage {
                        VStack(spacing: 4) {
                            Text("Competitive pricing! Contact Hilary at")
                                .font(.system(size: 18, design: .serif))
                                .foregroundColor(.black.opacity(0.8))
                                .transition(.opacity)
                            Text("hilary@bodypositivedancefitness.com")
                                .font(.system(size: 18, weight: .bold, design: .serif))
                                .foregroundColor(.orange)
                                .transition(.opacity)
                        }
                        .transition(.opacity)
                    }
                }
                .padding(.horizontal)
                VStack(spacing: 16) {
                    ExpandableSection(title: "Venue Amenities", items: amenities)
                    ExpandableSection(title: "Private Events", items: privateEvents)
                    ExpandableSection(title: "General Space Rental", items: spaceRental)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}


