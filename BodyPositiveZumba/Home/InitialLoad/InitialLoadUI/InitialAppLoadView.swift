//
//  InitialAppLoadView.swift
//  InitialLoad
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct InitialAppLoadView: View {

    @StateObject private var viewModel = InitialAppLoadViewModel()

    var body: some View {
        VStack {
            if viewModel.viewState.showHomeScreen {
                HomeView()
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
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 20)

                        Capsule()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [viewModel.viewState.barColorStart, viewModel.viewState.barColorEnd]
                                    ),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(
                                width: viewModel.viewState.progress * UIScreen.main.bounds.width * 0.8,
                                height: 20
                            )
                            .animation(
                                .linear(
                                    duration: viewModel.barLoadDuration
                                ),
                                value: viewModel.viewState.progress
                            )
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8)

                    Text(Constants.Common.tradeMarkSlogan)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .opacity(viewModel.viewState.fadeInProgress)
                        .foregroundColor(viewModel.viewState.textColor)
                        .onAppear {
                            withAnimation(
                                Animation.easeIn(duration: 0.8)
                            ) {
                                viewModel.startAnimations()
                            }
                        }
                }
                .onAppear {
                    viewModel.startLoading()
                }
            }
        }
    }
}
