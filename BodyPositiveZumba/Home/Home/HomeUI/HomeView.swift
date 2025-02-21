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
                        handleCarouselExpansionChange(newValue, proxy: proxy)
                    }
                    .onDisappear {
                        resetCarouselState()
                    }
                }

                SideDrawerComponent(viewModel: sideDrawerViewModel)
                    .onChange(of: dragState.translation) { _, translation in
                        handleSideDrawerDrag(translation)
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
        VStack(spacing: 20) {
            ColoredButton(
                title: Constants.Home.bookClassesButton,
                action: { onAction?(.joinNow) },
                strokeColor: Color.orange,
                gradientColor: Color.orange
            )
            ColoredButton(
                title: Constants.Home.viewClassesButton,
                action: { onAction?(.viewClasses) },
                strokeColor: Constants.Colors.darkerCyan,
                gradientColor: Constants.Colors.neonCyan
            )
            VStack(spacing: 2) {
                ColoredButton(
                    title: Constants.Home.viewPassesButton,
                    action: { onAction?(.bookClass) },
                    strokeColor: Constants.Colors.darkerCyan,
                    gradientColor: Constants.Colors.neonCyan
                )
                Text(Constants.Home.passesBio)
                    .font(.sfProDisplayRegular(size: 18))
                    .foregroundColor(.gray)
                    .italic()
                    .padding(.top, 4)
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

    private func handleCarouselExpansionChange(_ isExpanded: Bool, proxy: ScrollViewProxy) {
        if isExpanded {
            viewState.showCarousel = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeIn(duration: 1.11)) {
                    viewState.showCarousel = true
                }
            }
        } else {
            collapseCarousel(proxy: proxy)
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

    private func resetCarouselState() {
        viewState.showCarousel = false
    }

    private func handleSideDrawerDrag(_ translation: CGFloat) {
        if !sideDrawerViewModel.viewState.isMenuOpen {
            sideDrawerViewModel.updateDragOffset(CGSize(width: max(0, translation), height: 0))
        }
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
