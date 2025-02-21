//
//  ClassesView.swift
//  Classes
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct ClassesView: View, ActionableView {

    enum Action {
        case toggleExpansion
        case handleViewAllButtonTap
    }

    @Binding var viewState: ClassesViewState
    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 0) {
                        headerSection
                        carouselSection
                        expansionToggleButton
                        if viewState.isBioExpanded { bioText }
                        buttonsSection
                    }
                    .padding(.bottom, 20)
                }
                swipeAnimationOverlay
            }
            .sheet(item: $viewState.viewCalendarWebView) { web in
                WebViewContainer(url: web.url, title: web.title)
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton { dismiss() }
                ToolbarButton.closeButton { dismiss() }
            }
            .onChange(of: viewState.showSwipeAnimation) { _, newValue in
                if newValue {
                    dismissSwipeAnimationAfterDelay()
                }
            }
        }
    }
}

private extension ClassesView {

    private struct RainbowButton: View {

        let title: String
        let action: () -> Void
        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.sfProRoundedTextMedium(size: 24))
                    .foregroundColor(.black)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 11)
                    .frame(width: 333, height: 60)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                LinearGradient(
                                    colors: Constants.Colors.rainbow,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 8
                            )
                    )
                    .cornerRadius(8)
                    .shadow(radius: 4)
            }
            .buttonStyle(PressableButton())
        }
    }

    var headerSection: some View {

        VStack(spacing: 0) {
            Text(Constants.Classes.pageTitle)
                .font(.sfProDisplayBold(size: 40))
                .multilineTextAlignment(.center)
                .foregroundColor(adaptiveTextColor)
                .padding(.top, 11)
                .padding(.bottom, 20)

            HStack(spacing: 0) {
                Text(Constants.Classes.pageBioPt1)
                    .font(.sfProBodyTextMedium(size: 26))
                    .foregroundColor(adaptiveTextColor.opacity(0.9))
                Text(Constants.Classes.pageBioPt2)
                    .font(.sfProBodyTextMedium(size: 26))
                    .italic()
                    .underline()
                    .foregroundStyle(
                        LinearGradient(
                            colors: Constants.Colors.rainbow,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                Text(Constants.Classes.pageBioPt3)
                    .font(.sfProBodyTextMedium(size: 26))
                    .foregroundColor(adaptiveTextColor.opacity(0.9))
            }
            .padding(.bottom, 35)
        }
    }

    var carouselSection: some View {

        SwipableCarouselComponent<AnyView, DanceClass>(
            viewModel: SwipableCarouselViewModel(viewState: $viewState.carouselViewState)
        ) { danceClass, isCurrentCard in
            AnyView(
                DanceClassCard(
                    danceClass: danceClass,
                    viewState: $viewState
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isCurrentCard ? danceClass.color : Color.clear,
                                lineWidth: isCurrentCard ? 6 : 0)
                )
            )
        }
        .frame(height: 333)
    }

    var expansionToggleButton: some View {

        Button(action: toggleExpansion) {
            HStack(spacing: 4) {
                Text(toggleButtonText)
                    .font(.sfProRoundedTextSemibold(size: 16))
                Image(systemName: viewState.isBioExpanded ? "chevron.up" : "chevron.right")
            }
            .foregroundColor(adaptiveTextColor)
            .multilineTextAlignment(.center)
            .padding(.top, 30)
        }
    }

    var bioText: some View {

        Text(viewState.currentDanceClass.description)
            .font(.sfProBodyTextRegular(size: 18))
            .foregroundColor(adaptiveTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    var buttonsSection: some View {

        VStack(spacing: 16) {
            RainbowButton(
                title: Constants.Classes.viewAllButtonText,
                action: openViewAllClasses
            )

            RainbowButton(
                title: Constants.Classes.viewCalendarButtonText,
                action: openCalendar
            )
        }
        .padding(.top, 40)
    }

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
                .transition(.opacity)
                .animation(.easeOut(duration: 1.5), value: viewState.showSwipeAnimation)
                .onAppear {
                    dismissSwipeAnimationAfterDelay()
                }
            }
        }
    }

    var toggleButtonText: String {

        viewState.isBioExpanded ?
        Constants.Classes.closeButtonText :
        "\(Constants.Classes.openButtonText)\(viewState.currentDanceClass.rawValue)!"
    }

    func toggleExpansion() {

        withAnimation(.easeInOut) {
            onAction?(.toggleExpansion)
        }
    }

    func openViewAllClasses() {

        viewState.showSwipeAnimation = false
        onAction?(.handleViewAllButtonTap)
    }

    func openCalendar() {

        viewState.showSwipeAnimation = false
        guard let url = URL(string: Constants.Classes.viewCalendarUrl) else { return }
        viewState.viewCalendarWebView = WebViewURL(
            title: Constants.Classes.viewCalendarButtonText,
            url: url
        )
    }

    func dismissSwipeAnimationAfterDelay() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation { viewState.showSwipeAnimation = false }
        }
    }
}

struct PressableButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.03), value: configuration.isPressed)
    }
}
