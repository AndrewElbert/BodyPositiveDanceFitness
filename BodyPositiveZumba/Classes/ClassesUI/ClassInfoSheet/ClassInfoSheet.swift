//
//  ClassInfoSheet.swift
//  Classes
//
//  Created by Andrew Elbert on 3/6/25.
//

import SwiftUI

struct classInfoSheet: View {

    let danceClass: DanceClass
    let adaptiveTextColor: Color
    let joinNowAction: () -> Void
    @Binding var showingInfo: Bool
    @Environment(\.dismiss) private var dismiss

    @State private var particles: [Particle] = {

        let symbols = ["♪", "♫", "✨", "💫", "🎵", "🌟", "⭐", "🎶"]
        return (0..<20).map { _ in
            Particle(
                position: CGPoint(
                    x: CGFloat.random(in: 50...UIScreen.main.bounds.width-50),
                    y: CGFloat.random(in: 50...UIScreen.main.bounds.height-50)
                ),
                size: CGFloat.random(in: 10...25),
                opacity: Double.random(in: 0.3...0.7),
                rotation: Double.random(in: 0...360),
                symbol: symbols.randomElement() ?? "🎶",
                animationDuration: Double.random(in: 3...6),
                offsetY: CGFloat.random(in: -80...80),
                offsetX: CGFloat.random(in: -40...40),
                additionalRotation: Double.random(in: -180...180),
                delay: Double.random(in: 0...0.5)
            )
        }
    }()

    @State private var scale: CGFloat = 0.8
    @State private var rotation: Double = -5
    @State private var animationsStarted = false

    struct Particle: Identifiable {

        let id = UUID()
        let position: CGPoint
        let size: CGFloat
        let opacity: Double
        let rotation: Double
        let symbol: String
        let animationDuration: Double
        let offsetY: CGFloat
        let offsetX: CGFloat
        let additionalRotation: Double
        let delay: Double
    }

    var body: some View {

        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [danceClass.color, Color.black]),
                center: .center,
                startRadius: 50,
                endRadius: 600
            )
            .edgesIgnoringSafeArea(.all)

            ForEach(particles) { particle in
                ParticleView(particle: particle, animationsStarted: animationsStarted)
            }

            VStack(spacing: 20) {

                VStack(spacing: 10) {
                    Image(systemName: "music.quarternote.3")
                        .font(.system(size: 40))
                        .foregroundColor(danceClass.color)
                        .padding(.top, 15)

                    Text(danceClass.rawValue)
                        .font(.sfProDisplayBold(size: 32))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.white, .white.opacity(0.7)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .rotationEffect(.degrees(rotation))
                        .scaleEffect(scale)
                }

                Rectangle()
                    .fill(danceClass.color)
                    .frame(width: 344, height: 3)
                    .cornerRadius(1.5)

                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(Constants.Classes.descriptionTitle)
                            .font(.sfProDisplaySemibold(size: 26))
                            .foregroundColor(danceClass.color)
                            .brightness(-0.22)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .underline()
                            .padding(.bottom, 16)

                        Text(danceClass.description)
                            .font(.sfProBodyTextRegular(size: 18))
                            .foregroundColor(adaptiveTextColor)
                            .lineSpacing(5)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.8))
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 2)
                )
                .padding(.horizontal, 20)

                Spacer()

                HStack(spacing: 15) {

                    Button(action: { showingInfo = false }) {
                        Text(Constants.Classes.closeButton)
                            .font(.sfProRoundedTextSemibold(size: 18))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(Color.gray)
                            )
                    }

                    Button(action: {
                        showingInfo = false
                        joinNowAction()
                    }) {
                        Text(Constants.Classes.joinNowButtonText)
                            .font(.sfProRoundedTextSemibold(size: 18))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(danceClass.color)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                rotation = 0
                scale = 1.0
            }
            animationsStarted = true
        }
    }
}

struct ParticleView: View {

    let particle: classInfoSheet.Particle
    let animationsStarted: Bool

    @State private var position: CGPoint
    @State private var rotation: Double
    @State private var opacity: Double

    init(particle: classInfoSheet.Particle, animationsStarted: Bool) {
        self.particle = particle
        self.animationsStarted = animationsStarted
        _position = State(initialValue: particle.position)
        _rotation = State(initialValue: particle.rotation)
        _opacity = State(initialValue: particle.opacity)
    }

    var body: some View {
        Text(particle.symbol)
            .font(.system(size: particle.size))
            .foregroundColor(Color.white.opacity(opacity))
            .position(position)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                guard animationsStarted else { return }

                withAnimation(
                    Animation.easeInOut(duration: particle.animationDuration)
                        .repeatForever(autoreverses: true)
                        .delay(particle.delay)
                ) {
                    position.y += particle.offsetY
                    position.x += particle.offsetX
                    rotation += particle.additionalRotation
                    opacity = Double.random(in: 0.4...0.8)
                }
            }
            .onChange(of: animationsStarted) {_, newValue in
                if newValue {
                    withAnimation(
                        Animation.easeInOut(duration: particle.animationDuration)
                            .repeatForever(autoreverses: true)
                            .delay(particle.delay)
                    ) {
                        position.y += particle.offsetY
                        position.x += particle.offsetX
                        rotation += particle.additionalRotation
                        opacity = Double.random(in: 0.4...0.8)
                    }
                }
            }
    }
}
