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
    @Environment(\.colorScheme) private var colorScheme
    @Binding var viewState: MassageViewState

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    public init(
        viewState: Binding<MassageViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        ZStack {
            mainContent
            swipeAnimationOverlay
        }
        .padding()
        .onAppear {
            withAnimation(.easeIn.delay(0.2)) {
                viewState.showCarousel = true
            }
            dismissSwipeAnimationAfterDelay()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation(.easeOut(duration: 0.005)) {
                        viewState.showCarousel = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                        dismiss()
                    }
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                    .font(.system(size: 17, weight: .regular))
                }
            }
        }
        .sheet(item: $viewState.bookingURL) { booking in
            WebViewContainer(url: booking.url, title: booking.title)
        }
    }
}

private extension MassageView {
    var mainContent: some View {
        VStack {
            headerSection
            if viewState.showCarousel {
                carouselSection
                    .transition(.opacity)
            }
            Spacer()
            actionButton
        }
    }

    var headerSection: some View {
        VStack(spacing: 0) {
            Text(viewState.pageTitle)
                .font(.sfProDisplayBold(size: 34))
                .multilineTextAlignment(.center)
                .foregroundColor(adaptiveTextColor)
                .padding(.top, 0)
                .padding(.bottom, 16)

            Text(viewState.pageBio)
                .font(.sfProBodyTextRegular(size: 16))
                .foregroundColor(adaptiveTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 16)
        }
    }

    var carouselSection: some View {
        SwipableCarouselComponent<AnyView, CardModel>(
            viewModel: SwipableCarouselViewModel(
                viewState: $viewState.swipableCarouselViewState
            )
        ) { card, isCurrentCard in
            AnyView(
                MassageCardView(card: card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isCurrentCard ? Color.orange : Color.clear,
                                    lineWidth: 4)
                    )
                    .shadow(
                        color: isCurrentCard ? Color.orange.opacity(0.3) : Color.clear,
                        radius: 40
                    )
            )
        }
        .frame(height: 400)
    }

    var actionButton: some View {
        Button(action: { onAction?(.updateUrl) }) {
            Text(Constants.Massage.buttonText)
                .font(.sfProRoundedTextMedium(size: 24))
                .foregroundColor(.black)
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .background(
                    ZStack {
                        Color.white
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Constants.Colors.neonCyan.opacity(0.1),
                                Constants.Colors.neonCyan.opacity(0.5)
                            ]),
                            center: .center,
                            startRadius: 50,
                            endRadius: 100
                        )
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.orange, lineWidth: 3)
                )
                .cornerRadius(8)
        }
        .padding(.top, 2)
    }

    var swipeAnimationOverlay: some View {
        Group {
            if viewState.showSwipeAnimation {
                VStack(spacing: 8) {
                    Text(Constants.Massage.swipe)
                        .font(.sfProRoundedTextMedium(size: 18))
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
        }
    }

    func dismissSwipeAnimationAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            withAnimation { viewState.showSwipeAnimation = false }
        }
    }
}
