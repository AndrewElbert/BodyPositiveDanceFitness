//
//  InitialAppLoadView.swift
//  InitialLoadUI
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

    var onAction: ((Action) -> Void )?
    @Binding var viewState: InitialAppLoadViewState

    public init(
        viewState: Binding<InitialAppLoadViewState>,
        onAction: ( (Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                if viewState.showHomeScreen {
                    Color.clear.onAppear {
                        onAction?(.navigateHomeScreen)
                    }
                } else {
                    Image(Constants.Common.logoName)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .scaleEffect(0.9)
                        .padding(.top, 50)

                    VStack {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .stroke(viewState.barOutlineColor, lineWidth: 6)
                                .frame(height: 20)

                            Capsule()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: [viewState.barColorStart, viewState.barColorEnd]
                                        ),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(
                                    width: viewState.progress * UIScreen.main.bounds.width * 0.8,
                                    height: 20
                                )
                                .animation(
                                    .linear(
                                        duration: viewState.barLoadDuration
                                    ),
                                    value: viewState.progress
                                )
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8)

                        Text(Constants.Common.tradeMarkSlogan)
                            .font(
                                .sfProRoundedTextBold(
                                    size: Constants.Home.tradeMarkSloganSize
                                    )
                            )
                            .multilineTextAlignment(.center)
                            .padding(.top)
                            .opacity(viewState.fadeInProgress)
                            .foregroundColor(viewState.textColor)
                            .onAppear {
                                withAnimation(
                                    Animation.easeIn(duration: 0.8)
                                ) {
                                    onAction?(.startAnimations)
                                }
                            }
                    }
                    .onAppear {
                        onAction?(.startLoading)
                    }
                }
            }
        }
    }
}
