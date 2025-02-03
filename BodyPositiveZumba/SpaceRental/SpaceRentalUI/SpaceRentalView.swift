//
//  SpaceRentalView.swift
//  SpaceRentalUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct SpaceRentalView: View, ActionableView {
    
    enum Action {
        case toggleMessage
    }
    
    @Environment(\.dismiss) var dismiss
    @Binding var viewState: SpaceRentalViewState
    var onAction: ((Action) -> Void )?
    
    public init(
        viewState: Binding<SpaceRentalViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    CloseButton(dismiss: { dismiss() })
                        .padding(.trailing, 16)
                        .padding(.top, 16)
                }
                
                Text(Constants.SpaceRental.pageTitle)
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.Colors.darkerCyan)
                    .padding(.horizontal)
                
                Text(Constants.SpaceRental.pageBio)
                    .font(.system(size: 16, design: .serif))
                    .foregroundColor(.black.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                
                VStack(spacing: 16) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            onAction?(.toggleMessage)
                        }
                    }) {
                        Text(Constants.SpaceRental.buttonText)
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                RadialGradient(
                                    gradient: Gradient(colors: [
                                        Constants.Colors.neonCyan.opacity(0.1),
                                        Constants.Colors.neonCyan.opacity(0.5)
                                    ]),
                                    center: .center, startRadius: 8, endRadius: 88
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.orange, lineWidth: 2)
                            )
                            .cornerRadius(10)
                    }
                    
                    if viewState.showMessage {
                        VStack(spacing: 4) {
                            Text(Constants.SpaceRental.inquireTodayTitleText)
                                .font(.system(size: 18, design: .serif))
                                .foregroundColor(.black.opacity(0.8))
                                .transition(.opacity)
                            Text(Constants.SpaceRental.contact)
                                .font(.system(size: 15, weight: .bold, design: .serif))
                                .foregroundColor(.orange)
                                .transition(.opacity)
                        }
                        .transition(.opacity)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                AnimatedCarouselComponent(
                    viewModel: AnimatedCarouselViewModel(
                        viewState: $viewState.animatedCarouselViewState
                    )
                )
                    .frame(height: 250)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                VStack(spacing: 16) {
                    VStack(spacing: 16) {
                        ExpandableSectionComponent(
                            viewModel: ExpandableSectionViewModel(viewState: $viewState.amenitiesSectionState)
                        )
                        ExpandableSectionComponent(
                            viewModel: ExpandableSectionViewModel(viewState: $viewState.privateEventsSectionState)
                        )
                        ExpandableSectionComponent(
                            viewModel: ExpandableSectionViewModel(viewState: $viewState.spaceRentalSectionState)
                        )
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                .padding()
            }
        }
    }
}

