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
    @Binding private var viewState: HomeViewState
    @StateObject private var sideDrawerViewModel: SideDrawerViewModel
    @GestureState private var dragState = DragState.inactive

    enum DragState {
        case inactive
        case dragging(translation: CGFloat)
        var translation: CGFloat {
            switch self {
            case .inactive: return 0
            case .dragging(let translation): return translation
            }
        }
    }

    var onAction: ((Action) -> Void)?

    public init(
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
            ZStack {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            mainContent
                                .id(Constants.Home.proxy)
                            if viewState.isCarouselExpanded {
                                carouselSection
                                    .transition(.opacity)
                            }
                        }
                    }
                    .onChange(of: viewState.isCarouselExpanded) { _, newValue in
                        if newValue {
                            viewState.showCarousel = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.easeIn(duration: 1.11)) {
                                    viewState.showCarousel = true
                                }
                            }
                        } else {
                            withAnimation(.easeOut(duration: 0.3)) {
                                viewState.showCarousel = false
                            }
                            withAnimation(.spring(duration: 1.1)) {
                                proxy.scrollTo(Constants.Home.proxy, anchor: .top)
                            }
                        }
                    }
                    .onDisappear {
                        viewState.showCarousel = false
                    }
                }
                SideDrawerComponent(viewModel: sideDrawerViewModel)
                    .onChange(of: dragState.translation) { _, translation in
                        if !sideDrawerViewModel.viewState.isMenuOpen {
                            sideDrawerViewModel.updateDragOffset(
                                CGSize(
                                    width: max(0, translation),
                                    height: 0))
                        }
                    }
            }
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
        .frame(maxWidth: .infinity, maxHeight: viewState.isCarouselExpanded ? nil : .infinity)
    }

    private var greetingView: some View {
        VStack(spacing: 11) {
            Text(viewState.currentGreeting)
                .font(.sfProDisplayBold(size: 35))
                .italic()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 0)
            Text(Constants.Home.pageBio)
                .font(.sfProDisplayRegular(size: 18))
                .foregroundColor(.gray)
                .italic()
        }
    }

    private var logoView: some View {
        ZStack {
            Image(Constants.Common.logoName)
                .resizable()
                .scaledToFit()
                .frame(height: 222)
        }
        .padding(.bottom, 22)
    }

    private var buttonStack: some View {
        VStack(spacing: 22) {
            ColoredButton(
                title: Constants.Home.bookClassesButton,
                onTap: { onAction?(.joinNow) },
                strokeColor: Color.orange.opacity(0.8),
                gradientColor: Color.orange
            )
            ColoredButton(
                title: Constants.Home.viewClassesButton,
                onTap: { onAction?(.viewClasses) },
                strokeColor: Constants.Colors.darkerCyan,
                gradientColor: Constants.Colors.neonCyan
            )
            VStack(spacing: 2) {
                ColoredButton(
                    title: Constants.Home.viewPassesButton,
                    onTap: { onAction?(.bookClass) },
                    strokeColor: Constants.Colors.darkerCyan,
                    gradientColor: Constants.Colors.neonCyan
                )
                Text(Constants.Home.passesBio)
                    .font(.sfProDisplayRegular(size: 18))
                    .foregroundColor(.gray)
                    .italic()
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
        Button(action: {
            withAnimation(.spring(duration: 0.8)) {
                viewState.isCarouselExpanded.toggle()
            }
        }) {
            HStack(spacing: 4) {
                Text(Constants.Home.photosButton)
                    .font(.sfProDisplayRegular(size: 18))
                    .foregroundColor(.gray)

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
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

    private func createSideDrawerGesture() -> some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .updating($dragState) { value, state, _ in
                guard value.startLocation.x < 50 else { return }
                state = .dragging(translation: value.translation.width)
            }
            .onEnded { value in
                guard value.startLocation.x < 50 else { return }
                let threshold = Constants.SideDrawer.frameWidth * 0.3
                if value.translation.width > threshold { sideDrawerViewModel.openMenu() }
            }
    }
}

struct ColoredButton: View {
    let title: String
    let onTap: () -> Void
    let strokeColor: Color
    let gradientColor: Color

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(
                    ZStack {
                        Color.white
                        RadialGradient(
                            gradient: Gradient(colors: [
                                gradientColor.opacity(0.05),
                                gradientColor.opacity(0.2)
                            ]),
                            center: .center,
                            startRadius: 55,
                            endRadius: 122
                        )
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(strokeColor, lineWidth: 8)
                )
                .cornerRadius(8)
        }
        .frame(height: 55)
    }
}

struct HomeRainbowButton: View {
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 18))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: Constants.Colors.rainbow
                                ),
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
