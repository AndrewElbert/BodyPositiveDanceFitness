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

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    var body: some View {
        VStack(spacing: 0) {
            cardHeader
            Spacer()
            headerText
            Spacer()
            joinNowButton
        }
        .frame(width: 250, height: 350)
        .background(cardBackground)
        .cornerRadius(15)
        .overlay(cardBorder)
        .shadow(color: danceClass.color.opacity(0.3), radius: 8, x: 0, y: 4)
        .sheet(item: $viewState.joinNowURL) { joinNow in
            WebViewContainer(url: joinNow.url, title: joinNow.title)
        }
    }

    private var cardHeader: some View {
        Rectangle()
            .fill(danceClass.color.opacity(0.8))
            .frame(height: 70)
            .overlay(
                Image(systemName: "music.note.list")
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
            .font(.sfProDisplayBold(size: 30))
            .fontWeight(.bold)
            .foregroundColor(adaptiveTextColor)
            .multilineTextAlignment(.center)
            .shadow(color: Color.white.opacity(0.5), radius: 1, x: 0, y: 1)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 15)
    }

    private var joinNowButton: some View {
        Button(action: openJoinURL) {
            Text(Constants.Classes.joinNowButtonText)
                .font(.sfProRoundedTextSemibold(size: 20))
                .foregroundColor(adaptiveTextColor)
                .frame(width: 180, height: 44)
                .background(Color.white.opacity(0.3))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
        .padding(.top, 20)
        .padding(.bottom, 15)
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
            .strokeBorder(danceClass.color, lineWidth: 1.5)
    }

    private func openJoinURL() {
        guard let url = URL(string: Constants.JoinNow.joinNowUrl) else { return }
        viewState.joinNowURL = WebViewURL(
            title: Constants.Classes.joinNowButtonText,
            url: url
        )
    }
}
