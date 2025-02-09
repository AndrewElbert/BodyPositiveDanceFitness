//
//  TeamView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/9/25.
//

import SwiftUI

struct TeamView: View, ActionableView {
    
    enum Action {
        case updateUrl
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

private extension TeamView {
    var mainContent: some View {
        VStack {
            headerSection
            if viewState.showCarousel {
                carouselSection
                    .transition(.opacity)
            }
            Spacer()
        }
    }

    var headerSection: some View {
        
        Text("Meet The Team!")
            .font(.sfProDisplayBold(size: 34))
            .multilineTextAlignment(.center)
            .foregroundColor(adaptiveTextColor)
            .padding(.top, 0)
            .padding(.bottom, 16)
    }

    var carouselSection: some View {
        SwipableCarouselComponent<AnyView, CardModel>(
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
                        color: isCurrentCard ? Constants.Colors.neonCyan.opacity(0.3) : Color.clear,
                        radius: 40
                    )
            )
        }
        .frame(height: 400)
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
