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
