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
    var onAction: ((Action) -> Void)?
    
    public init(
        viewState: Binding<SpaceRentalViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        CloseButton(dismiss: { dismiss() })
                    }
                    
                    Text(Constants.SpaceRental.pageTitle)
                        .font(.system(size: 23, weight: .bold, design: .serif))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(Constants.SpaceRental.pageBio)
                        .font(.system(size: 16, design: .serif))
                        .foregroundColor(Constants.Colors.darkOrange)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                    
                    VStack(spacing: 24) {
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
                                    .font(.system(size: 19, design: .serif))
                                    .foregroundColor(.black.opacity(0.8))
                                    .transition(.opacity)
                                Text(Constants.SpaceRental.contact)
                                    .font(.system(size: 17, weight: .bold, design: .serif))
                                    .foregroundColor(Constants.Colors.darkOrange)
                                    .transition(.opacity)
                            }
                            .transition(.opacity)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .zIndex(1)
                    
                    AnimatedCarouselComponent(
                        viewModel: AnimatedCarouselViewModel(
                            viewState: $viewState.animatedCarouselViewState
                        )
                    )
                    .frame(height: 250)
                    .padding(.horizontal)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    .zIndex(0)
                    
                    VStack(spacing: 16) {
                        ExpandableSectionComponent(
                            viewModel: ExpandableSectionViewModel(
                                viewState: $viewState.amenitiesSectionState
                            )
                        )
                        .id("amenitiesSection")
                        .onChange(of: viewState.amenitiesSectionState.isExpanded) { notNeeded, isExpanded in
                            if isExpanded {
                                withAnimation {
                                    proxy.scrollTo("amenitiesSection", anchor: .center)
                                }
                            }
                        }
                     
                        ExpandableSectionComponent(
                            viewModel: ExpandableSectionViewModel(
                                viewState: $viewState.privateEventsSectionState
                            )
                        )
                        .id("privateEventsSection")
                        .onChange(of: viewState.privateEventsSectionState.isExpanded) { notNeeded, isExpanded in
                            if isExpanded {
                                withAnimation {
                                    proxy.scrollTo("privateEventsSection", anchor: .center)
                                }
                            }
                        }
    
                        ExpandableSectionComponent(
                            viewModel: ExpandableSectionViewModel(
                                viewState: $viewState.spaceRentalSectionState
                            )
                        )
                        .id("spaceRentalSection")
                        .onChange(of: viewState.spaceRentalSectionState.isExpanded) { notNeeded, isExpanded in
                            if isExpanded {
                                withAnimation {
                                    proxy.scrollTo("spaceRentalSection", anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                .padding()
            }
        }
    }
}


