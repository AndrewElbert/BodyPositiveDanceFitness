//
//  InitialAppLoadView.swift
//  Home
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

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

            if viewState.showHomeScreen {
                Color.clear.onAppear { onAction?(.navigateHomeScreen) }
            } else {
                content
                    .overlay(
                        Group {
                            if viewState.showShootingStar {
                                ShootingStarView()
                            }
                        }
                    )
            }
        }
    }

    private var content: some View {

        VStack {
            logo
            progressBar
                .onAppear { onAction?(.startLoading) }
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
            .ignoresSafeArea()
            .scaleEffect(0.9)
            .padding(.top, 50)
    }

    private var progressBar: some View {

        VStack {
            ZStack(alignment: .leading) {
                Capsule()
                    .stroke(viewState.barOutlineColor, lineWidth: 5)
                    .frame(height: 20)
                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [viewState.barColorStart, viewState.barColorEnd]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: viewState.progress * UIScreen.main.bounds.width * 0.8, height: 20)
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
    }
}

struct ShootingStarView: View {

    @State private var animate: Bool = false

    var body: some View {

        GeometryReader { geometry in
            Text("✨")
                .font(.system(size: 38))
                .shadow(color: .yellow, radius: 10, x: 0, y: 0)
                .offset(
                    x: animate ? geometry.size.width * 1.2 : -110,
                    y: animate ? geometry.size.height * 0.35 : -260
                )
                .animation(
                    Animation.linear(duration: 1.8),
                    value: animate
                )
                .onAppear {
                    animate = true
                }
        }
        .ignoresSafeArea()
    }
}
