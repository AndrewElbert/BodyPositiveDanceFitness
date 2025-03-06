//
//  DanceClassCard.swift
//  Classes
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct DanceClassCard: View {

    var danceClass: DanceClass
    @Binding var viewState: ClassesViewState
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var showingInfo = false
    @State private var isDancing = false

    private var adaptiveTextColor: Color {

        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    var body: some View {

        VStack(spacing: 0) {

            Rectangle()
                .fill(danceClass.color.opacity(0.5))
                .frame(height: 70)
                .overlay(
                    Image(systemName: "sparkles")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 15)
                        .padding(.bottom, -15)
                )

            HStack {

                ForEach(0..<3) { index in
                    Image(systemName: "figure.dance")
                        .font(.system(size: index == 1 ? 70 : 50))
                        .foregroundColor(danceClass.color)
                        .shadow(color: danceClass.color.opacity(0.3), radius: 3, x: 0, y: 2)
                        .rotationEffect(.degrees(isDancing ? 9 : -4))
                        .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: isDancing)
                        .onAppear(perform: index == 0 ? { isDancing = true } : {})
                }
            }
            .padding(.vertical, 11)

            Text(danceClass.rawValue)
                .font(.sfProDisplayBold(size: 26))
                .fontWeight(.bold)
                .foregroundColor(adaptiveTextColor)
                .multilineTextAlignment(.center)
                .shadow(color: Color.white.opacity(0.5), radius: 1, x: 0, y: 1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
                .offset(y: -10)

            Spacer()

            VStack(spacing: 10) {

                Button(action: { showingInfo = true }) {
                    HStack {
                        Text(Constants.Classes.learnMoreButtonText)
                            .font(.sfProRoundedTextSemibold(size: 18))
                        Image(systemName: "wand.and.stars")
                            .font(.system(size: 20))
                            .bold()
                    }
                }
                .buttonStyle(learnMoreButton(color: danceClass.color, textColor: .black))

                Button(action: openJoinURL) {

                    HStack {
                        Text(Constants.Classes.joinNowButtonText)
                            .font(.sfProRoundedTextSemibold(size: 18))
                        Image(systemName: "flame.fill")
                            .foregroundColor(danceClass.color)
                            .bold()
                            .shadow(color: danceClass.color.opacity(0.5), radius: 3, x: 0, y: 2)
                    }
                }
                .buttonStyle(joinNowButton(color: danceClass.color, adaptiveTextColor: adaptiveTextColor))
            }
            .padding(.bottom, 15)
        }
        .frame(width: 260, height: 400)
        .background(
            RadialGradient(
                gradient: Gradient(colors: [
                    danceClass.color.opacity(0.05),
                    danceClass.color.opacity(0.38)
                ]),
                center: .center,
                startRadius: 50,
                endRadius: 250
            )
        )
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(danceClass.color, lineWidth: 2.2)
        )
        .shadow(color: danceClass.color.opacity(0.3), radius: 8, x: 0, y: 4)
        .sheet(item: $viewState.joinNowURL) { joinNow in
            WebViewContainer(url: joinNow.url, title: joinNow.title)
        }
        .sheet(isPresented: $showingInfo) {
            classInfoSheet(
                danceClass: danceClass,
                adaptiveTextColor: adaptiveTextColor,
                joinNowAction: openJoinURL,
                showingInfo: $showingInfo
            )
        }
    }

    private func openJoinURL() {

        guard let url = URL(string: Constants.JoinNow.joinNowUrl) else { return }
        viewState.joinNowURL = WebViewURL(
            title: Constants.Classes.joinNowButtonText,
            url: url
        )
    }
}

struct learnMoreButton: ButtonStyle {

    var color: Color
    var textColor: Color = .white

    func makeBody(configuration: Configuration) -> some View {

        configuration.label
            .frame(width: 222, height: 44)
            .foregroundColor(textColor)
            .background(color)
            .cornerRadius(55)
            .overlay(
                RoundedRectangle(cornerRadius: 55)
                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
                    .blur(radius: 2)
            )
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct joinNowButton: ButtonStyle {

    var color: Color
    var adaptiveTextColor: Color

    func makeBody(configuration: Configuration) -> some View {

        configuration.label
            .frame(width: 222, height: 44)
            .foregroundColor(adaptiveTextColor)
            .background(.ultraThinMaterial)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 55)
                    .stroke(LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.65)]),
                        startPoint: .leading,
                        endPoint: .trailing),
                            lineWidth: 2.5)
            )
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct classInfoSheet: View {

    let danceClass: DanceClass
    let adaptiveTextColor: Color
    let joinNowAction: () -> Void
    @Binding var showingInfo: Bool
    @Environment(\.dismiss) private var dismiss

    @State private var particles: [Particle] = []
    @State private var scale: CGFloat = 0
    @State private var rotation: Double = -5

    struct Particle: Identifiable {
        let id = UUID()
        var position: CGPoint
        var size: CGFloat
        var opacity: Double
        var rotation: Double
        var symbol: String
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
                Text(particle.symbol)
                    .font(.system(size: particle.size))
                    .foregroundColor(Color.white.opacity(particle.opacity))
                    .position(particle.position)
                    .rotationEffect(.degrees(particle.rotation))
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
                        .onAppear {
                            withAnimation(.spring(response: 0.01, dampingFraction: 0.6)) {
                                rotation = 0
                                scale = 1.0
                            }
                        }
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
                            .brightness(-0.222222222222222222)
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
        .onAppear { createParticles() }
    }

    private func createParticles() {

        let symbols = ["♪", "♫", "✨", "💫", "🎵", "🌟", "⭐", "🎶"]
        for _ in 0..<30 {
            let particle = Particle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                ),
                size: CGFloat.random(in: 10...30),
                opacity: Double.random(in: 0.3...0.7),
                rotation: Double.random(in: 0...360),
                symbol: symbols.randomElement() ?? "✨"
            )
            particles.append(particle)
            let index = particles.count - 1
            withAnimation(
                Animation.easeInOut(duration: Double.random(in: 3...8))
                    .repeatForever(autoreverses: true)
                    .delay(Double.random(in: 0...2))
            ) {
                particles[index].position.y += CGFloat.random(in: -100...100)
                particles[index].position.x += CGFloat.random(in: -50...50)
                particles[index].rotation += Double.random(in: -180...180)
                particles[index].opacity = Double.random(in: 0.1...0.5)
            }
        }
    }
}
