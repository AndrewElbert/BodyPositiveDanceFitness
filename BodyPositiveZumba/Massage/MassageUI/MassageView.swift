//
//  MassageView.swift
//  MassageUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct MassageView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MassageViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Text(viewModel.viewState.pageTitle)
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.Colors.darkerCyan)
                    .padding()

                Text(viewModel.viewState.pageBio)
                    .font(.system(size: 16, design: .serif))
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 16)

                InfiniteCarouselView(items: viewModel.viewState.cards,
                                       currentIndex: $viewModel.viewState.currentIndex,
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

                    SwipeAnimationView(isAnimating: $viewModel.viewState.isAnimating)
                }
                .padding(.top, 60)
                .padding(.bottom, 15)

                Button(action: {
                    viewModel.updateBookingURL()
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
        .sheet(item: $viewModel.viewState.bookingURL) { booking in
            WebView(url: booking.url)
                .overlay(
                    CloseButton(dismiss: {
                        dismiss()
                    }))
                .edgesIgnoringSafeArea(.all)
        }
    }
}

