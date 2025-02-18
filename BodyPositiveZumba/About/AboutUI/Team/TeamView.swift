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

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Binding var viewState: TeamViewState

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    public init(
        viewState: Binding<TeamViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    mainContent
                }
                swipeAnimationOverlay
            }
            .padding()
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
    }
}

private extension TeamView {
    var mainContent: some View {
        VStack {
            headerSection
            if viewState.showCarousel {
                carouselSection
                    .transition(.opacity)
                    .padding(.bottom, 40)
                bioSection
                    .transition(.opacity)
            }
            Spacer(minLength: 0)
        }
    }

    var headerSection: some View {
        Text(Constants.Team.teamPageTitle)
            .font(.sfProDisplayBold(size: 34))
            .multilineTextAlignment(.center)
            .foregroundColor(adaptiveTextColor)
            .padding(.top, 0)
            .padding(.bottom, 16)
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
        .padding(.bottom, 16)
    }

    var bioSection: some View {
        VStack(spacing: 4) {
            Button(action: {
                withAnimation(.easeInOut) {
                    viewState.isBioExpanded.toggle()
                }
            }) {
                HStack(spacing: 8) {
                    Text("Learn more about \(viewState.bios[viewState.normalizedIndex].firstName)!")
                        .font(.sfProRoundedTextMedium(size: 16))
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(viewState.isBioExpanded ? 90 : 0))
                }
                .foregroundColor(adaptiveTextColor)
                .padding(.horizontal, 20)
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
        .padding(.top, 20)
    }

    var swipeAnimationOverlay: some View {
        Group {
            if viewState.showSwipeAnimation {
                SwipeAnimationComponent(
                    viewModel: SwipeAnimationViewModel(
                        viewState: viewState.swipeAnimationViewState
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation { viewState.showSwipeAnimation = false }
        }
    }
}
