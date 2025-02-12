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
    }

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Binding var viewState: ClassesViewState

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    public init(
        viewState: Binding<ClassesViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
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
            .sheet(item: $viewState.viewAllClassesWebView) { web in
                WebViewContainer(url: web.url, title: web.title)
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton { dismiss() }
                ToolbarButton.closeButton { dismiss() }
            }
            .onAppear {
                dismissSwipeAnimationAfterDelay()
            }
        }
    }
}

private extension ClassesView {
    
    private struct RainbowButton: View {
        let title: String
        let action: () -> Void
        let font: Font
        @Environment(\.colorScheme) private var colorScheme
        
        private var adaptiveTextColor: Color {
            colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
        }
        
        init(
            title: String,
            font: Font = .sfProRoundedTextMedium(size: 20),
            action: @escaping () -> Void
        ) {
            self.title = title
            self.font = font
            self.action = action
        }
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(font)
                    .foregroundColor(adaptiveTextColor)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 11)
                    .frame(width: 280, height: 60)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .red,
                                        .orange,
                                        .yellow,
                                        .green,
                                        .blue,
                                        .purple
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 6
                            )
                    )
                    .cornerRadius(8)
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
                Text("Explore our ")
                    .font(.sfProBodyTextMedium(size: 24))
                    .foregroundColor(adaptiveTextColor.opacity(0.9))
                Text("Colors")
                    .font(.sfProBodyTextMedium(size: 24))
                    .italic()
                    .underline()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                .red,
                                .orange,
                                .yellow,
                                .green,
                                .blue,
                                .purple
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                Text(" below!")
                    .font(.sfProBodyTextMedium(size: 24))
                    .foregroundColor(adaptiveTextColor.opacity(0.9))
                    .multilineTextAlignment(.center)
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
                                lineWidth: isCurrentCard ? 3 : 0)
                )
                .shadow(
                    color: isCurrentCard ? danceClass.color.opacity(0.8) : Color.clear,
                    radius: 40, x: 0, y: 0
                )
                .shadow(
                    color: isCurrentCard ? danceClass.color.opacity(0.6) : Color.clear,
                    radius: 50, x: 0, y: 0
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
        VStack(spacing: 20) {
            RainbowButton(
                title: Constants.Classes.viewAllButtonText,
                action: openViewAllClassesURL
            )
            
            RainbowButton(
                title: "View Calendar",
                action: openCalendar
            )
        }
        .padding(.top, 50)
    }

    var swipeAnimationOverlay: some View {
        Group {
            if viewState.showSwipeAnimation {
                SwipeAnimationComponent(
                    viewModel: SwipeAnimationViewModel(
                        viewState: viewState.swipeAnimationViewState
                    )
                )
                .padding()
                .zIndex(1)
                .transition(.opacity)
                .animation(.easeOut(duration: 1.5), value: viewState.showSwipeAnimation)
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

    func openViewAllClassesURL() {
        guard let url = URL(string: Constants.Classes.viewAllClassesUrl) else { return }
        viewState.viewAllClassesWebView = WebViewURL(
            title: Constants.Classes.viewAllButtonText,
            url: url
        )
    }
    
    func openCalendar() {
        // TODO: Handle calendar action here
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
