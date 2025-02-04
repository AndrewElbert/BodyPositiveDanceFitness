//
//  MassageView.swift
//  MassageUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct MassageView: View, ActionableView {
    enum Action {
        case updateUrl
    }

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) var dismiss
    @Binding var viewState: MassageViewState

    public init(
        viewState: Binding<MassageViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        ZStack {
            VStack {
                Text(viewState.pageTitle)
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.Colors.darkerCyan)
                    .padding()

                Text(viewState.pageBio)
                    .font(.system(size: 16, design: .serif))
                    .foregroundColor(.black.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                
                Divider()

                SwipableCarouselComponent<AnyView, CardModel>(
                    viewModel: SwipableCarouselViewModel(
                        viewState: $viewState.swipableCarouselViewState
                    )
                ) { card, isCurrentCard in
                    AnyView(
                        SwipableCardView(card: card)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(isCurrentCard ? Color.orange : Color.clear, lineWidth: 4)
                            )
                            .shadow(color: isCurrentCard ? Color.orange.opacity(0.3) : Color.clear, radius: 40)
                    )
                }
                .frame(height: 400)
                
                Spacer()

                Button(action: {
                    onAction?(.updateUrl)
                }) {
                    Text(Constants.Massage.buttonText)
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 20
                        )
                        .background(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Constants.Colors.neonCyan.opacity(0.1),
                                    Constants.Colors.neonCyan.opacity(0.5)
                                ]),
                                center: .center, startRadius: 50, endRadius: 100
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.orange, lineWidth: 3)
                        )
                        .cornerRadius(8)
                }
                .padding(.top, 2)
            }
            .padding()

            if viewState.showSwipeAnimation {
                VStack(spacing: 8) {
                    Text(Constants.Massage.swipe)
                        .font(
                            .system(
                                size: 16,
                                weight: .medium,
                                design: .serif
                            )
                        )
                        .foregroundColor(.gray)

                    SwipeAnimationComponent(
                        viewModel: SwipeAnimationViewModel(
                            viewState: viewState.swipeAnimationViewState
                        )
                    )
                }
                .padding()
                .offset(x: -60, y: -120)
                .rotationEffect(.degrees(-20))
                .zIndex(1)
                .transition(.opacity)
                .animation(.easeOut(duration: 1.5), value: viewState.showSwipeAnimation)
            }

            CloseButton(dismiss: {
                dismiss()
            })
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                withAnimation {
                    viewState.showSwipeAnimation = false
                }
            }
        }
        .sheet(item: $viewState.bookingURL) { booking in
            WebView(url: booking.url)
                .overlay(
                    CloseButton(dismiss: {
                        dismiss()
                    }))
                .edgesIgnoringSafeArea(.all)
        }
    }
}





