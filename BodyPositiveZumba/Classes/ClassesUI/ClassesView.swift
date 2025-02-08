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
    @Environment(\.colorScheme) private var colorScheme  // Added to detect dark vs. light mode
    @Binding var viewState: ClassesViewState

    public init(
        viewState: Binding<ClassesViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }
    
    // This computed property returns black in light mode and white in dark mode.
    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack(spacing: 0) {
                    headerSection
                    carouselSection
                    expansionToggleButton
                    if viewState.isBioExpanded { bioText }
                    viewAllClassesButton
                }
                .padding(.bottom, 20)
            }
            closeButton.padding()
        }
        .sheet(item: $viewState.viewAllClassesWebView) { web in
            WebViewContainer(url: web.url, title: web.title)
        }
    }
}

private extension ClassesView {

    var headerSection: some View {
        VStack(spacing: 0) {
            Text(Constants.Classes.pageTitle)
                .font(.system(size: 33, weight: .bold, design: .serif))
                .multilineTextAlignment(.center)
                .foregroundColor(adaptiveTextColor)
                .padding(.top, 40)
                .padding(.bottom, 8)

            Text(Constants.Classes.pageBio)
                .font(.system(size: 20, weight: .semibold, design: .serif))
                .foregroundColor(adaptiveTextColor.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 25)
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
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                Image(systemName: viewState.isBioExpanded ? "chevron.right" : "chevron.down")
            }
            .foregroundColor(adaptiveTextColor)
            .multilineTextAlignment(.center)
            .padding(.top, 30)
        }
    }

    var bioText: some View {
        Text(viewState.currentDanceClass.description)
            .font(.system(size: 18, design: .serif))
            .foregroundColor(adaptiveTextColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    var viewAllClassesButton: some View {
        Button(action: openViewAllClassesURL) {
            Text(Constants.Classes.viewAllButtonText)
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundColor(adaptiveTextColor)
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .background(viewState.currentDanceClass.color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(adaptiveTextColor, lineWidth: 3)
                )
                .cornerRadius(8)
        }
        .padding(.top, 50)
        .buttonStyle(PressableButton())
    }

    var closeButton: some View {
        CloseButton {
            dismiss()
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
}

struct PressableButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.03), value: configuration.isPressed)
    }
}

