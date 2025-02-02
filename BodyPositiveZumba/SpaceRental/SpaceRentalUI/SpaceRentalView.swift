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

    @Environment(\.dismiss) var dismiss
    @State private var showMessage = false

    private let amenities = [
        ("Three available spaces of varying sizes dependent upon scheduling", "🏢"),
        ("Tables, chairs, tablecloths, whiteboards, speakers, projectors", "🪑"),
        ("Convenient location & easy parking, with many nearby amenities", "🚗"),
        ("Includes usage of 1,890 sf room, 1366 sf room, or 668 sf room", "📐")
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

    private let spaceImages = [
        "SpaceRental1",
        "SpaceRental2",
        "SpaceRental3",
        "SpaceRental4"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    CloseButton(dismiss: {
                        dismiss()
                    })
                    .padding(.trailing, 16)
                    .padding(.top, 16)
                }

                Text("Private Events & Space Rental")
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.Colors.darkerCyan)
                    .padding(.horizontal)

                Text("If you can dream it, we can help you achieve it!")
                    .font(.system(size: 16, design: .serif))
                    .foregroundColor(.black.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                VStack(spacing: 16) {
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
                                .font(.system(size: 15, weight: .bold, design: .serif))
                                .foregroundColor(.orange)
                                .transition(.opacity)
                        }
                        .transition(.opacity)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)

                CircularCarousel(
                    images: spaceImages
                )
                .frame(height: 250)
                .padding(.horizontal)
                .padding(.top, 20)

                VStack(spacing: 16) {
                    ExpandableSection(title: "Venue Amenities", items: amenities)
                    ExpandableSection(title: "Private Events", items: privateEvents)
                    ExpandableSection(title: "General Space Rental", items: spaceRental)
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            .padding()
        }
    }
}

struct CircularCarousel: View {
    let images: [String]
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.cyan.opacity(0.6),
                                Color.cyan.opacity(0.5)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blur(radius: 40)

                HStack(spacing: 0) {
                    ForEach(0..<images.count * 8, id: \.self) { index in
                        Image(images[index % images.count])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.cyan.opacity(0.3), lineWidth: 2)
                                    .shadow(color: .cyan.opacity(0.3), radius: 5)
                            )
                    }
                }
                .frame(width: geometry.size.width * CGFloat(images.count * 8), height: geometry.size.height)
                .offset(x: -geometry.size.width * CGFloat(currentIndex) + dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold = geometry.size.width * 0.3
                            withAnimation(.easeInOut(duration: 1.25)) {
                                if value.translation.width > threshold {
                                    currentIndex -= 1
                                } else if value.translation.width < -threshold {
                                    currentIndex += 1
                                }
                                dragOffset = 0
                            }
                            currentIndex = (currentIndex + images.count * 8) % (images.count * 8)
                        }
                )
                .animation(.easeInOut(duration: 1.25), value: dragOffset)

                HStack(spacing: 8) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex % images.count ? Color.cyan : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                            .scaleEffect(index == currentIndex % images.count ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: currentIndex)
                    }
                }
                .padding(.bottom, 16)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 1.25)) {
                currentIndex += 1
                currentIndex = (currentIndex + images.count * 8) % (images.count * 8)
            }
        }
    }
}
