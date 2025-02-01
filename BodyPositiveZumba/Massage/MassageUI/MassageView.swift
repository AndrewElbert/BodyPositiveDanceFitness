//
//  MassageView.swift
//  MassageUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct MassageView: View {
    
    let cardsData: [CardModel] = [
        CardModel(
            id: UUID(),
            name: Constants.HeadShots.LindseyHerseyName,
            imageName: Constants.HeadShots.LindseyHerseyHeadShot,
            parlor: Constants.Massage.LindseyHerseyParlor,
            bio: Constants.Massage.LindseyHerseyBio
        ),
        CardModel(
            id: UUID(),
            name: Constants.HeadShots.ShelbySwannName,
            imageName: Constants.HeadShots.ShelbySwannHeadShot,
            parlor: Constants.Massage.ShelbySwannParlor,
            bio: Constants.Massage.ShelbySwannBio
        )
    ]

    @Environment(\.dismiss) var dismiss
    @State private var currentIndex: Int = 0
    @State private var isAnimating = false
    @State private var isCardExpanded = false
    @State private var bookingURL: WebViewURL?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Text(Constants.Massage.pageTitle)
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.Colors.darkerCyan)
                    .padding()

                Text(Constants.Massage.pageBio)
                    .font(.system(size: 16, design: .serif))
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 16)

                InfiniteCarouselView(items: cardsData,
                                       currentIndex: $currentIndex,
                                       spacing: 10,
                                       sideSpacing: 40) { card, isCurrentCard in
                    SwipableCardView(card: card)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isCurrentCard ? Color.orange : Color.clear, lineWidth: 3)
                        )
                        .shadow(color: isCurrentCard ? Color.orange.opacity(0.3) : Color.clear, radius: 10)
                }
                .frame(height: 400)

                VStack(spacing: 8) {
                    Text("Swipe")
                        .font(.system(size: 16, weight: .medium, design: .serif))
                        .foregroundColor(.gray)

                    SwipeAnimationView(isAnimating: $isAnimating)
                }
                .padding(.top, 60)
                .padding(.bottom, 15)

                Button(action: {
                    let normalizedIndex = ((currentIndex % cardsData.count) + cardsData.count) % cardsData.count

                    var urlString: String
                    if normalizedIndex == 0 {
                        urlString = Constants.Massage.ladyLoveHolisticURL
                    } else {
                        urlString = Constants.Massage.swannsHealingElementsURL
                    }

                    if let url = URL(string: urlString) {
                        bookingURL = WebViewURL(url: url)
                    }
                }) {
                    Text("Book Today!")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Constants.Colors.neonCyan.opacity(0.1),
                                    Constants.Colors.neonCyan.opacity(0.2)
                                ]),
                                center: .center, startRadius: 5, endRadius: 50
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.orange, lineWidth: 2)
                        )
                        .cornerRadius(8)
                }
                .padding(.top, 2)
            }

            CloseButton(dismiss: {
                dismiss()
            })
        }
        .sheet(item: $bookingURL) { booking in
            WebView(url: booking.url)
                .overlay(
                    CloseButton(dismiss: {
                        dismiss()
                    }))
                .edgesIgnoringSafeArea(.all)
        }
    }
}
