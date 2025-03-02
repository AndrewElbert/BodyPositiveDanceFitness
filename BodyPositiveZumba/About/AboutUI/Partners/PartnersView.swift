//
//  PartnersView.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

struct PartnersView: View {

    @Binding var viewState: PartnersViewState
    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 0) {
                    header

                    descriptionText

                    divider

                    carouselView

                    Spacer()
                }
                .padding(.horizontal)
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
        }
        .sheet(item: $viewState.displayURL) { currentCard in
            WebViewContainer(url: currentCard.url, title: currentCard.title)
        }
        .onAppear {
            dismissSwipeAnimationAfterDelay()
        }
        .preferredColorScheme(.light)
    }

    private var header: some View {

        HStack(spacing: 13) {
            Image(Constants.Common.logoName)
                .resizable()
                .scaledToFit()
                .frame(width: 121, height: 121)
                .clipped()
                .padding(.top, 0)

            Text(Constants.Partners.pageTitle)
                .font(.sfProDisplayBold(size: 38))
                .foregroundStyle(.black)
                .padding(.top, 17)
                .padding(.bottom, 12)
        }
    }

    private var descriptionText: some View {

        Text(Constants.Partners.pageBio)
            .font(.sfProBodyTextRegular(size: 16))
            .foregroundColor(.gray)
            .italic()
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
            .padding(.bottom, 11)
    }

    private var divider: some View {

        Divider()
            .frame(
                width: UIScreen.main.bounds.width - 60,
                height: 1.5
            )
            .background(
                LinearGradient(
                    colors: Constants.Colors.logoColorGradient,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .padding(.bottom, 11)
    }

    private var carouselView: some View {

        SwipableCarouselComponent<AnyView, Partner>(
            viewModel: SwipableCarouselViewModel(viewState: $viewState.carouselViewState)
        ) { partner, isCurrentCard in
            AnyView(
                PartnersCard(partner: partner, viewState: $viewState, isCurrentCard: isCurrentCard)
            )
        }
        .overlay(
            swipeAnimationOverlay,
            alignment: .center
        )
        .frame(height: 400)
    }

    private var swipeAnimationOverlay: some View {

        Group {
            if viewState.showSwipeAnimation {
                SwipeAnimationComponent(
                    viewModel: SwipeAnimationViewModel(
                        viewState: $viewState.swipeAnimationViewState
                    )
                )
                .padding()
                .zIndex(1)
                .transition(.scale(scale: 0.8).combined(with: .opacity))
                .animation(.easeOut(duration: 1.5), value: viewState.showSwipeAnimation)
            }
        }
    }

    private func dismissSwipeAnimationAfterDelay() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation { viewState.showSwipeAnimation = false }
        }
    }
}
