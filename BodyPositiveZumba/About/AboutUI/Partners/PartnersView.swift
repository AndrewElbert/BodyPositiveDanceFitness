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
            VStack {
                Text(Constants.Partners.pageTitle)
                    .font(.sfProDisplayBold(size: 40))
                    .foregroundColor(.black)
                    .padding(.top, 26)
                    .padding(.bottom, 30)

                SwipableCarouselComponent<AnyView, Partner>(
                    viewModel: SwipableCarouselViewModel(viewState: $viewState.carouselViewState)
                ) { partner, isCurrentCard in
                    AnyView(
                        PartnersCard(partner: partner, viewState: $viewState)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(isCurrentCard ? Color.orange : Color.clear,
                                            lineWidth: isCurrentCard ? 3 : 0)
                            )
                            .overlay(
                                swipeAnimationOverlay,
                                alignment: .center
                            )
                    )
                }
                .frame(height: 375)
                Spacer()
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton { dismiss() }
                ToolbarButton.closeButton { dismiss() }
            }
        }
        .sheet(item: $viewState.displayURL) { currentCard in
            WebViewContainer(url: currentCard.url, title: currentCard.title)
        }
        .onAppear {
            dismissSwipeAnimationAfterDelay()
        }
    }
}

private extension PartnersView {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            withAnimation { viewState.showSwipeAnimation = false }
        }
    }
}
