//
//  InitialAppLoadView.swift
//  Home
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI
import EffectsLibrary

struct InitialAppLoadView: View {

    enum Action {
        case navigateHomeScreen
        case startLoading
        case startAnimations
    }

    @Binding var viewState: InitialAppLoadViewState
    var onAction: ((Action) -> Void)?

    var body: some View {

        ZStack {
            
            Color.white.ignoresSafeArea()
            
            if viewState.showFireWork {
                FireWorksView()
                    .ignoresSafeArea()
                    .zIndex(0)
            }

            if viewState.showHomeScreen {
                Color.clear.onAppear { onAction?(.navigateHomeScreen) }
            } else {
                content
                    .zIndex(1)
            }
        }
    }

    private var content: some View {

        VStack {
            logo
            progressBar
                .onAppear {
                    onAction?(
                        .startLoading
                    )
                }
        }
    }

    private var logo: some View {

        Image(Constants.Common.logoName)
            .resizable()
            .scaledToFit()
            .shadow(
                color: .gray.opacity(viewState.logoShadowOpacity),
                radius: 11,
                x: 0,
                y: 5
            )
            .scaleEffect(0.95)
            .ignoresSafeArea()
            .padding(.top, 50)
    }

    private var progressBar: some View {

        VStack {
            ZStack(alignment: .leading) {
                Capsule()
                    .stroke(viewState.barOutlineColor, lineWidth: 5.5)
                    .frame(height: 22)
                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [viewState.barColorStart, viewState.barColorEnd]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: viewState.progress * UIScreen.main.bounds.width * 0.8, height: 22)
                    .animation(.linear(duration: viewState.barLoadDuration), value: viewState.progress)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8)

            Text(Constants.Common.tradeMarkSlogan)
                .font(.sfProRoundedTextBold(size: Constants.Home.tradeMarkSloganSize))
                .multilineTextAlignment(.center)
                .padding(.top)
                .opacity(viewState.fadeInProgress)
                .foregroundColor(viewState.textColor)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.8)) {
                        onAction?(.startAnimations)
                    }
                }
        }
        .padding(.top, 26)
    }
}

struct FireWorksView: View {
    
    var body: some View {
        FireworksView(
            config: FireworksConfig(
                intensity: .medium,
                lifetime: .long,
                initialVelocity: .fast,
                fadeOut: .slow,
                spreadRadius: .high
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}
