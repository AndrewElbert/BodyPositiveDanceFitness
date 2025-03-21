//
//  HomeView.swift
//  Home
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct HomeView: View {

    enum Action {

        case viewClasses
        case about
        case joinNow
        case bookClass
    }

    let coordinator: SideDrawerCoordinator
    var onAction: ((Action) -> Void)?
    @Binding private var viewState: HomeViewState
    @StateObject private var sideDrawerViewModel: SideDrawerViewModel
    @GestureState private var dragState = HomeDragState.inactive

    enum HomeDragState {

        case inactive
        case dragging(translation: CGFloat)

        var translation: CGFloat {
            switch self {
            case .inactive: return 0
            case .dragging(let translation): return translation
            }
        }
    }

    init(
        coordinator: SideDrawerCoordinator,
        viewState: Binding<HomeViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self.coordinator = coordinator
        self._viewState = viewState
        self.onAction = onAction

        self._sideDrawerViewModel = StateObject(
            wrappedValue: SideDrawerViewModel(
                coordinator: coordinator
            )
        )
    }

    var body: some View {

        if viewState.deathScreenEnabled {
            MaintenanceView()
        } else {
            mainView
                .sheet(isPresented: $viewState.showJoinWebView) {
                    WebViewContainer(
                        url: URL(string: Constants.JoinNow.joinNowUrl)!,
                        title: Constants.JoinNow.joinNowTitle
                    )
                }
                .sheet(isPresented: $viewState.showBookClassWebView) {
                    WebViewContainer(
                        url: URL(string: Constants.JoinNow.passesUrl)!,
                        title: Constants.JoinNow.passesTitle
                    )
                }
                .preferredColorScheme(.light)
        }
    }

    private var mainView: some View {

        ZStack {
            scrollContent
            SideDrawerComponent(viewModel: sideDrawerViewModel)
                .onChange(of: dragState.translation) { _, translation in
                    handleSideDrawerDrag(translation)
                }
        }
    }

    private var scrollContent: some View {

        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    mainContent.id(Constants.Home.proxy)
                    if viewState.isCarouselExpanded {
                        carouselSection
                            .id("carouselSection")
                            .transition(.opacity)
                    }
                }
            }
            .onChange(of: viewState.isCarouselExpanded) { _, newValue in
                handleCarouselExpansionChange(newValue, proxy: proxy)
            }
            .onDisappear {
                viewState.showCarousel = false
            }
        }
    }

    private var mainContent: some View {

        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                TopBarComponent(viewModel: sideDrawerViewModel)
                contentStack
            }
            .gesture(createSideDrawerGesture())
        }
    }

    private var contentStack: some View {

        VStack(spacing: 0) {
            greetingView
            logoView
            buttonStack
            expandablePhotoButton
            if !viewState.isCarouselExpanded {
                Spacer()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: viewState.isCarouselExpanded ? nil : .infinity
        )
    }

    private var greetingView: some View {

        VStack(spacing: 11) {

            Text(viewState.currentGreeting)
                .font(.sfProDisplayBold(size: 35))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 0)
            Text(Constants.Home.pageBio)
                .font(.sfProDisplayRegular(size: 18))
                .foregroundColor(Constants.Colors.navy)
                .italic()
        }
    }

    private var logoView: some View {

        AnimatedLogoView().padding(.bottom, 22)
    }

    private var buttonStack: some View {

        VStack(spacing: 20) {
            ColoredButton(
                title: Constants.Home.bookClassesButton,
                action: { onAction?(.joinNow) },
                strokeColor: Constants.Colors.navy
            )

            ColoredButton(
                title: Constants.Home.viewClassesButton,
                action: { onAction?(.viewClasses) },
                strokeColor: Constants.Colors.navy
            )

            VStack(spacing: 2) {
                Text(Constants.Home.passesBio)
                    .font(.sfProDisplayRegular(size: 19))
                    .foregroundColor(Constants.Colors.navy)
                    .italic()

                ModernPassesButton {
                    onAction?(.bookClass)
                }
                .padding(.top, 0)
            }

            HStack(spacing: 16) {
                HomeRainbowButton(title: Constants.Home.aboutButton) {
                    onAction?(.about)
                }
                HomeRainbowButton(title: Constants.Home.exploreButton) {
                    sideDrawerViewModel.openMenu()
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
    }

    private var expandablePhotoButton: some View {

        Button(action: toggleCarousel) {
            HStack(spacing: 6) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Constants.Colors.navy)
                Text(Constants.Home.photosButton)
                    .font(.sfProDisplayRegular(size: 18))
                    .foregroundColor(Constants.Colors.navy)

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Constants.Colors.navy)
                    .rotationEffect(.degrees(viewState.isCarouselExpanded ? 90 : 0))
            }
            .padding(.top, 24)
            .padding(.bottom, 18)
        }
        .zIndex(1)
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
        .opacity(viewState.showCarousel ? 1 : 0)
    }

    private func toggleCarousel() {

        buttonVibration()
        withAnimation(.spring(duration: 0.8)) {
            viewState.isCarouselExpanded.toggle()
        }
    }

    private func createSideDrawerGesture() -> some Gesture {

        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .updating($dragState) { value, state, _ in
                guard value.startLocation.x < 50 else { return }
                state = .dragging(translation: value.translation.width)
            }
            .onEnded { value in
                guard value.startLocation.x < 50 else { return }
                let threshold = Constants.SideDrawer.frameWidth * 0.3
                if value.translation.width > threshold {
                    sideDrawerViewModel.openMenu()
                }
            }
    }

    private func handleCarouselExpansionChange(_ isExpanded: Bool, proxy: ScrollViewProxy) {

        if isExpanded {
            expandCarousel(proxy: proxy)
        } else {
            collapseCarousel(proxy: proxy)
        }
    }

    private func expandCarousel(proxy: ScrollViewProxy) {

        viewState.showCarousel = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeIn(duration: 1.1)) {
                viewState.showCarousel = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(duration: 0.8)) {
                    proxy.scrollTo("carouselSection", anchor: .top)
                }
            }
        }
    }

    private func collapseCarousel(proxy: ScrollViewProxy) {

        withAnimation(.easeOut(duration: 0.3)) {
            viewState.showCarousel = false
        }

        withAnimation(.spring(duration: 1.1)) {

            proxy.scrollTo(Constants.Home.proxy, anchor: .top)
        }
    }

    private func handleSideDrawerDrag(_ translation: CGFloat) {

        if !sideDrawerViewModel.viewState.isMenuOpen {
            sideDrawerViewModel.updateDragOffset(CGSize(width: max(0, translation), height: 0))
        }
    }
}

struct ModernPassesButton: View {

    @State private var isPressed = false
    @State private var isAnimating = false
    let action: () -> Void

    private let textGradient = LinearGradient(
        gradient: Gradient(colors: Constants.Colors.homeExploreGradient),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {

        Button(action: handleButtonPress) {
            HStack(spacing: 20) {
                gradientIcon(systemName: "ticket.fill", leftRotation: true)

                Text(Constants.Home.viewPassesButton)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(textGradient)
                    .scaleEffect(isPressed ? 0.95 : 1)
                    .overlay(
                        Text(Constants.Home.viewPassesButton)
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .opacity(isPressed ? 0.7 : 0)
                    )

                gradientIcon(systemName: "figure.socialdance", leftRotation: false)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .contentShape(Rectangle())
            .scaleEffect(isPressed ? 0.97 : 1)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear { isAnimating = true
        }

    }

    private func gradientIcon(systemName: String, leftRotation: Bool) -> some View {

        Image(systemName: systemName)
            .font(.system(size: 30, weight: .bold))
            .foregroundStyle(textGradient)
            .rotationEffect(.degrees(isAnimating ? (leftRotation ? 22 : 20) : (leftRotation ? -22 : -20)))
            .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
            .scaleEffect(isPressed ? 0.9 : 1)
    }

    private func handleButtonPress() {

        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            isPressed = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {

            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isPressed = false
            }
            action()
        }

        buttonVibration()
    }
}

struct HomeRainbowButton: View {

    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: {
            buttonVibration()
            onTap()
        }) {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 20))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: Constants.Colors.rainbow),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 8
                        )
                )
                .cornerRadius(8)
        }
        .frame(height: 55)
    }
}
