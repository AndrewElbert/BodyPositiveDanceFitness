//
//  MassageView.swift
//  Massage
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct MassageView: View, ActionableView {

    enum Action {
        case updateUrl
    }

    @Binding var viewState: MassageViewState
    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    var body: some View {

        NavigationStack {
            ZStack {
                mainContent
                swipeAnimationOverlay
            }
            .padding()
            .onAppear {
                viewState.showCarousel = true
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
        .preferredColorScheme(.light)
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
            bookMassageButton
        }
    }

    var headerSection: some View {

        VStack(spacing: 0) {
            ZStack {
                Text(viewState.pageTitle)
                    .font(.sfProDisplayBold(size: 34))
                    .foregroundStyle(
                        LinearGradient(
                            colors: Constants.Colors.logoColorGradient,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .multilineTextAlignment(.center)
                    .blur(radius: 0.8888)
                    .offset(y: 0.8888)

                Text(viewState.pageTitle)
                    .font(.sfProDisplayBold(size: 34))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 0)
            .padding(.bottom, 8)

            Divider()

            Text(viewState.pageBio)
                .font(.sfProBodyTextRegular(size: 16))
                .italic()
                .foregroundColor(.black.opacity(0.77))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 8)
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
                        .stroke(isCurrentCard ?
                            LinearGradient(
                                gradient: Gradient(colors: Constants.Colors.logoColorGradient),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ) : LinearGradient(
                                gradient: Gradient(colors: [.clear]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                                lineWidth: 4.4)
                )
                    .shadow(
                        color: isCurrentCard ? Color.orange.opacity(0.22) : Color.clear,
                        radius: 33
                    )
            )
        }
        .frame(height: 400)
    }

    var bookMassageButton: some View {
        Button(
            action: {
                onAction?(.updateUrl)
            }) {
                Text("Book With \(viewState.currentTherapistName) Today!")
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(
                    LinearGradient(
                        colors: Constants.Colors.logoColorGradientLight,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(36)
        }
        .padding(.bottom, 11)
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
