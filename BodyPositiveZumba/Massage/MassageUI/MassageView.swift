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

    private var currentTherapistName: String {
        let count = viewState.cards.count
        let index = viewState.swipableCarouselViewState.currentIndex
        let normalizedIndex = ((index % count) + count) % count
        return viewState.cards[normalizedIndex].firstName
    }

    public init(
        viewState: Binding<MassageViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        NavigationStack {
            ZStack {
                mainContent
                swipeAnimationOverlay
            }
            .padding()
            .onAppear {
                withAnimation(.easeIn.delay(0.3)) {
                    viewState.showCarousel = true
                }
                dismissSwipeAnimationAfterDelay()
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton {
                    dismiss()
                }
                ToolbarButton.closeButton {
                    dismiss()
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
                .padding(.top, 11)
                .padding(.bottom, 16)

            Text(viewState.pageBio)
                .font(.sfProBodyTextRegular(size: 15))
                .italic()
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 16)
        }
    }

    var carouselSection: some View {
        SwipableCarouselComponent<AnyView, MassageCardModel>(
            viewModel: SwipableCarouselViewModel(
                viewState: $viewState.swipableCarouselViewState
            )
        ) { card, isCurrentCard in
            AnyView(
                MassageCardView(
                    card: card,
                    isCurrentCard: isCurrentCard,
                    viewState: viewState.massageCardViewState
                )
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
        Button(
            action: {
                onAction?(.updateUrl)
            }) {
            Text("Book With \(currentTherapistName) Today!")
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(buttonBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Constants.Colors.darkerCyan, lineWidth: 6)
                )
                .cornerRadius(8)
        }
        .padding(.top, 2)
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

private var buttonBackground: some View {
    ZStack {
        Color.white
        RadialGradient(
            gradient: Gradient(colors: [
                Constants.Colors.neonCyan.opacity(0.05),
                Constants.Colors.neonCyan.opacity(0.2)
            ]),
            center: .center,
            startRadius: 55,
            endRadius: 122
        )
    }
}
