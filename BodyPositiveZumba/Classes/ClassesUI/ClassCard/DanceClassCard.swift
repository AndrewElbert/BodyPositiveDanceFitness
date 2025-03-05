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
            cardHeader

            dancerIcons
                .padding(.vertical, 11)

            headerText
                .offset(y: -10)

            Spacer()

            buttonControls
                .padding(.bottom, 15)
        }
        .frame(width: 260, height: 400)
        .background(cardBackground)
        .cornerRadius(15)
        .overlay(cardBorder)
        .shadow(color: danceClass.color.opacity(0.3), radius: 8, x: 0, y: 4)
        .sheet(item: $viewState.joinNowURL) { joinNow in
            WebViewContainer(url: joinNow.url, title: joinNow.title)
        }
        .sheet(isPresented: $showingInfo) {
            infoSheet
        }
    }

    private var dancerIcons: some View {

        HStack {
            dancerIcon(size: 50, index: 0)
            dancerIcon(size: 70, index: 1)
            dancerIcon(size: 50, index: 2)
        }
    }

    private func dancerIcon(size: CGFloat, index: Int) -> some View {

        Image(systemName: "figure.dance")
            .font(.system(size: size))
            .foregroundColor(danceClass.color)
            .opacity(0.5)
            .shadow(color: danceClass.color.opacity(0.5), radius: 3, x: 0, y: 2)
            .rotationEffect(.degrees(isDancing ? 9 : -4))
            .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: isDancing)
            .onAppear(perform: index == 0 ? { isDancing = true } : {})
    }

    private var buttonControls: some View {

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
    }

    private var cardHeader: some View {

        Rectangle()
            .fill(danceClass.color.opacity(0.65))
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
    }

    private var headerText: some View {

        Text(danceClass.rawValue)
            .font(.sfProDisplayBold(size: 26))
            .fontWeight(.bold)
            .foregroundColor(adaptiveTextColor)
            .multilineTextAlignment(.center)
            .shadow(color: Color.white.opacity(0.5), radius: 1, x: 0, y: 1)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 15)
    }

    private var cardBackground: some View {

        RadialGradient(
            gradient: Gradient(colors: [
                danceClass.color.opacity(0.05),
                danceClass.color.opacity(0.38)
            ]),
            center: .center,
            startRadius: 50,
            endRadius: 250
        )
    }

    private var cardBorder: some View {

        RoundedRectangle(cornerRadius: 15)
            .strokeBorder(danceClass.color, lineWidth: 2.2)
    }

    private var infoSheet: some View {

        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [danceClass.color.opacity(0.01), danceClass.color.opacity(0.28)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                infoHeader

                divider

                infoContent

                Spacer()

                infoButtons
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
            }
        }
    }

    private var infoHeader: some View {

        VStack(spacing: 10) {
            Image(systemName: "music.quarternote.3")
                .font(.system(size: 40))
                .foregroundColor(danceClass.color)
                .padding(.top, 15)

            Text(danceClass.rawValue)
                .font(.sfProDisplayBold(size: 32))
                .foregroundColor(danceClass.color)
        }
    }

    private var divider: some View {
        Rectangle()
            .fill(danceClass.color)
            .frame(width: 344,
                   height: 3
            )
            .cornerRadius(1.5)
    }

    private var infoContent: some View {

        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(Constants.Classes.descriptionTitle)
                    .font(.sfProDisplaySemibold(size: 26))
                    .foregroundColor(danceClass.color)
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
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
    }

    private var infoButtons: some View {

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
                openJoinURL()
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
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [color, color.opacity(0.65)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(55)
            .overlay(
                RoundedRectangle(cornerRadius: 55)
                    .stroke(Color.white.opacity(0.8), lineWidth: 1)
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
