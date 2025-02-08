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

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @Environment(\.colorScheme) private var colorScheme
    @Binding private var viewState: SpaceRentalViewState
    var onAction: ((Action) -> Void)?

    private let titleStyle = Font.sfProDisplayBold(size: 23)
    private let bioStyle = Font.sfProBodyTextRegular(size: 18)
    private let buttonTextStyle = Font.sfProRoundedTextBold(size: 20)
    private let buttonAnimation = Animation.easeInOut(duration: 0.4)

    private var buttonGradient: some View {
        ZStack {
            Color.white
            RadialGradient(
                gradient: Gradient(colors: [
                    Constants.Colors.neonCyan.opacity(0.1),
                    Constants.Colors.neonCyan.opacity(0.5)
                ]),
                center: .center,
                startRadius: 8,
                endRadius: 88
            )
        }
    }
    
    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

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
                LazyVStack(spacing: 0) {
                    headerSection
                    messageSection
                    carouselSection

                    VStack(spacing: 16) {
                        ExpandableSectionComponent(
                            viewModel: ExpandableSectionViewModel(
                                viewState: $viewState.amenitiesSectionState
                            )
                        )
                        .id("amenitiesSection")
                        .onChange(of: viewState.amenitiesSectionState.isExpanded) { _, isExpanded in
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
                        .onChange(of: viewState.privateEventsSectionState.isExpanded) { _, isExpanded in
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
                        .onChange(of: viewState.spaceRentalSectionState.isExpanded) { _, isExpanded in
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

    private var headerSection: some View {
        Group {
            HStack {
                CloseButton {
                    dismiss()
                }
            }

            Text(Constants.SpaceRental.pageTitle)
                .font(titleStyle)
                .multilineTextAlignment(.center)
                .foregroundColor(adaptiveTextColor)
                .padding(.horizontal)

            Text(Constants.SpaceRental.pageBio)
                .font(bioStyle)
                .foregroundColor(adaptiveTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 16)
        }
    }

    private var messageSection: some View {
        VStack(spacing: 24) {
            actionButton

            if viewState.showMessage {
                messageContent
            }
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .zIndex(1)
    }

    private var actionButton: some View {
        Button(action: {
            withAnimation(buttonAnimation) {
                onAction?(.toggleMessage)
            }
        }) {
            Text(Constants.SpaceRental.buttonText)
                .font(buttonTextStyle)
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(buttonGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.orange, lineWidth: 2)
                )
                .cornerRadius(10)
        }
    }

    private var messageContent: some View {
        VStack(spacing: 4) {
            Text(Constants.SpaceRental.inquireTodayTitleText)
                .font(.sfProBodyTextRegular(size: 19))
                .foregroundColor(adaptiveTextColor)
            Text(Constants.SpaceRental.contact)
                .font(.sfProBodyTextBold(size: 17))
                .foregroundColor(.blue)
                .underline()
                .onTapGesture {
                    if let emailURL = URL(string: "mailto:\(Constants.SpaceRental.contact)") {
                        openURL(emailURL)
                    }
                }
        }
        .transition(.opacity)
    }

    private var carouselSection: some View {
        AnimatedCarouselComponent(
            viewModel: AnimatedCarouselViewModel(
                viewState: $viewState.animatedCarouselViewState
            )
        )
        .frame(height: 250)
        .padding(.horizontal)
        .padding(.vertical, 30)
        .zIndex(0)
    }
}

