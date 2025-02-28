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
    @Environment(\.colorScheme) private var colorScheme
    @State private var titleOpacity: Double = 0
    @State private var bioOpacity: Double = 0
    @State private var carouselScale: CGFloat = 0.5
    
    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text(Constants.Partners.pageTitle)
                    .font(.sfProDisplayBold(size: 45))
                    .foregroundColor(.clear)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: Constants.Colors.rainbow),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            Text(Constants.Partners.pageTitle)
                                .font(.sfProDisplayBold(size: 45))
                        )
                    )
                    .padding(.top, 26)
                    .padding(.bottom, 18)
                    .opacity(titleOpacity)
                    .blur(radius: 1.0 - titleOpacity)

                
                Text(Constants.Partners.pageBio)
                    .font(.sfProBodyTextRegular(size: 18))
                    .foregroundStyle(.gray)
                    .italic()
                    .padding(.bottom, 33)
                    .opacity(bioOpacity)
                    .blur(radius: 1.0 - bioOpacity)
                
                Divider()
                    .background(Color.gray)
                    .padding(.bottom, 30)
                
                SwipableCarouselComponent<AnyView, Partner>(
                    viewModel: SwipableCarouselViewModel(viewState: $viewState.carouselViewState)
                ) { partner, isCurrentCard in
                    AnyView(
                        PartnersCard(partner: partner, viewState: $viewState)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(isCurrentCard ? Constants.Colors.neonCyan : Color.clear,
                                            lineWidth: isCurrentCard ? 0.75 : 0)
                            )
                            .shadow(color: isCurrentCard ? Constants.Colors.neonCyan.opacity(0.3) : .black.opacity(0.1),
                                    radius: isCurrentCard ? 12 : 5,
                                    x: 0,
                                    y: isCurrentCard ? 6 : 3)
                    )
                }
                .overlay(
                    swipeAnimationOverlay,
                    alignment: .center
                )
                .frame(height: 375)
                .scaleEffect(carouselScale)
                
                Spacer()
                Divider()
                    .background(.gray)
                    .padding(.bottom, 30)
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
            animateEntrance()
        }
        .preferredColorScheme(.light)
    }
    
    private func animateEntrance() {
        withAnimation(.easeOut(duration: 1.5)) {
            titleOpacity = 1.0
        }
        withAnimation(.easeOut(duration: 1.5).delay(0.5)) {
            bioOpacity = 1.0
        }
        withAnimation(.spring(response: 1.0, dampingFraction: 0.8).delay(0.7)) {
            carouselScale = 1.0
        }
    }
}

private extension PartnersView {
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
                .transition(.scale(scale: 0.8).combined(with: .opacity))
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

