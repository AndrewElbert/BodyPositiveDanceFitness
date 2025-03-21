//
//  TeamView.swift
//  About
//
//  Created by Andrew Elbert on 2/9/25.
//

import SwiftUI

struct TeamView: View, ActionableView {

    enum Action {
        case toggleBio
    }

    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Binding var viewState: TeamViewState
    var onAction: ((Action) -> Void)?

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    mainContent
                }
                swipeAnimationOverlay
            }
            .onAppear {
                withAnimation(.easeIn.delay(0.02)) {
                    viewState.showCarousel = true
                }
                dismissSwipeAnimationAfterDelay()
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton { dismiss() }
                ToolbarButton.closeButton { dismiss() }
            }
        }
        .sheet(item: $viewState.bookingURL) { booking in
            WebViewContainer(url: booking.url, title: booking.title)
        }
        .preferredColorScheme(.light)
    }
}

private extension TeamView {

    var mainContent: some View {
        VStack(spacing: 0) {
            headerSection
            if viewState.showCarousel {
                carouselSection
                    .transition(.opacity)
                bioSection
                    .transition(.opacity)
            }
        }
    }

    var headerSection: some View {

        HStack {
            Text("The ")
                .font(.sfProDisplayBold(size: 34))
                .multilineTextAlignment(.center)
                .foregroundColor(adaptiveTextColor)
            Image(Constants.Common.logoName)
                .resizable()
                .scaledToFit()
                .frame(width: 133, height: 133)
            Text(" Team!")
                .font(.sfProDisplayBold(size: 34))
                .multilineTextAlignment(.center)
                .foregroundColor(adaptiveTextColor)
        }
        .padding(.top, 0)
        .padding(.bottom, 0)
    }

    var carouselSection: some View {
        SwipableCarouselComponent<AnyView, TeamCardModel>(
            viewModel: SwipableCarouselViewModel(
                viewState: $viewState.swipableCarouselViewState
            )
        ) { card, isCurrentCard in
            AnyView(
                TeamCardView(card: card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isCurrentCard ? Constants.Colors.neonCyan : Color.clear,
                                    lineWidth: 4)
                    )
                    .shadow(
                        color: isCurrentCard ? Constants.Colors.neonCyan.opacity(0.4) : Color.clear,
                        radius: 44
                    )
            )
        }
        .frame(height: 400)
    }

    var bioSection: some View {
        VStack(spacing: 4) {
            Button(action: {
                buttonVibration()
                withAnimation(.easeInOut) {
                    viewState.isBioExpanded.toggle()
                }
            }) {
                HStack(spacing: 8) {
                    Text("Learn more about \(viewState.bios[viewState.normalizedIndex].firstName)!")
                        .font(.system(size: 22, weight: .medium))
                        .italic()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15, weight: .medium))
                        .rotationEffect(.degrees(viewState.isBioExpanded ? 90 : 0))
                }
                .overlay(
                    Constants.Colors.learnMoreGradient
                        .mask(
                            HStack(spacing: 8) {
                                Text("Learn more about \(viewState.bios[viewState.normalizedIndex].firstName)!")
                                    .font(.system(size: 22, weight: .medium))
                                    .italic()
                                    .underline()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15, weight: .medium))
                                    .rotationEffect(.degrees(viewState.isBioExpanded ? 90 : 0))
                            }
                        )
                )
                .foregroundColor(.clear)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity)
            }

            if viewState.isBioExpanded {
                Text(viewState.bios[viewState.normalizedIndex].bio)
                    .font(.sfProBodyTextRegular(size: 18))
                    .foregroundColor(adaptiveTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.top, 18)
    }

    var swipeAnimationOverlay: some View {
        Group {
            if viewState.showSwipeAnimation {
                SwipeAnimationComponent(
                    viewModel: SwipeAnimationViewModel(
                        viewState: $viewState.swipeAnimationViewState
                    )
                )
                .padding()
                .zIndex(1)
                .transition(.opacity)
                .animation(.easeOut(duration: 1.5), value: viewState.showSwipeAnimation)
            }
        }
    }

    func dismissSwipeAnimationAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation { viewState.showSwipeAnimation = false }
        }
    }
}
