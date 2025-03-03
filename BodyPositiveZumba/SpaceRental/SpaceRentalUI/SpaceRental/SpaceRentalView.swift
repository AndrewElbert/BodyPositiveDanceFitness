//
//  SpaceRentalView.swift
//  SpaceRental
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
    @Binding var viewState: SpaceRentalViewState
    var onAction: ((Action) -> Void)?

    private let titleStyle = Font.sfProDisplayBold(size: 22)
    private let bioStyle = Font.sfProBodyTextRegular(size: 18)
    private let buttonTextStyle = Font.sfProRoundedTextSemibold(size: 20)
    private let buttonAnimation = Animation.easeInOut(duration: 0.4)

    private var buttonGradient: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            LinearGradient(
                gradient: Gradient(colors: [
                    Constants.Colors.neonCyan.opacity(0.01),
                    Constants.Colors.neonCyan.opacity(0.33)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Constants.Colors.neonCyan, lineWidth: 8)
        }
    }

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    var body: some View {

        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        headerSection
                        inquireSection

                        carouselSection
                            .opacity(viewState.showCarousel ? 1 : 0)
                            .animation(.easeIn(duration: 1.11), value: viewState.showCarousel)

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
                .onAppear {
                    withAnimation(.easeIn.delay(0.01)) {
                        viewState.showCarousel = true
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton {
                    dismiss()
                }
                ToolbarButton.closeButton {
                    dismiss()
                }
            }
            .preferredColorScheme(.light)
        }
    }

    private var headerSection: some View {
        VStack {
            Text(Constants.SpaceRental.pageTitle)
                .font(titleStyle)
                .multilineTextAlignment(.center)
                .foregroundColor(adaptiveTextColor)
                .padding(.horizontal)

            Text(Constants.SpaceRental.pageBio)
                .font(bioStyle)
                .italic()
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 12)
        }
    }

    private var inquireSection: some View {
        VStack(spacing: 24) {
            inquireButton

            if viewState.showMessage {
                inquireContent
            }
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .zIndex(1)
    }

    private var inquireButton: some View {
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
                .cornerRadius(16)
        }
    }

    private var inquireContent: some View {
        VStack(spacing: 4) {
            Text(Constants.SpaceRental.inquireTodayTitleText)
                .font(.sfProBodyTextRegular(size: 19))
                .foregroundColor(adaptiveTextColor)
            Text(Constants.SpaceRental.contact)
                .font(.sfProBodyTextRegular(size: 17))
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
