//
//  DanceClassCard.swift
//  ClassesUI
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct DanceClassCard: View {

    var danceClass: DanceClass
    @Binding var viewState: ClassesViewState

    var body: some View {
        VStack {
            headerText
            joinNowButton
        }
        .frame(width: 250, height: 350)
        .background(cardBackground)
        .overlay(cardOverlay)
        .cornerRadius(15)
        .shadow(color: danceClass.color.opacity(0.8), radius: 30, x: 0, y: 0)
        .shadow(color: danceClass.color.opacity(0.4), radius: 40, x: 0, y: 0)
        .sheet(item: $viewState.joinNowURL) { joinNow in
            WebViewContainer(url: joinNow.url, title: joinNow.title)
        }
    }
}

private extension DanceClassCard {

    var headerText: some View {
        Text(danceClass.rawValue)
            .font(.sfProDisplayBold(size: 30))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
    }

    var joinNowButton: some View {
        Button(action: openJoinURL) {
            Text(Constants.Classes.joinNowButtonText)
                .font(.sfProRoundedTextSemibold(size: 20))
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

    var cardBackground: some View {
        RadialGradient(
            gradient: Gradient(colors: [
                danceClass.color.opacity(0.01),
                danceClass.color.opacity(0.1)
            ]),
            center: .center,
            startRadius: 77,
            endRadius: 111
        )
    }

    var cardOverlay: some View {
        RoundedRectangle(cornerRadius: 15)
            .strokeBorder(danceClass.color, lineWidth: 2)
    }

    func openJoinURL() {
        guard let url = URL(string: Constants.JoinNow.joinNowUrl) else { return }
        viewState.joinNowURL = WebViewURL(
            title: Constants.Classes.joinNowButtonText,
            url: url
        )
    }
}
