//
//  HomeView.swift
//  HomeUI
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct HomeView: View {

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

    enum Action {
        case viewClasses, about, joinNow, bookClass
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
        ZStack {
            mainContent
            SideDrawerComponent(viewModel: sideDrawerViewModel)
                .onChange(of: dragState.translation) { _, translation in
                    if !sideDrawerViewModel.viewState.isMenuOpen {
                        sideDrawerViewModel.updateDragOffset(CGSize(width: max(0, translation), height: 0))
                    }
                }
        }
        .sheet(isPresented: $viewState.showJoinWebView) {
            WebViewContainer(
                url: URL(string: Constants.JoinNow.joinNowUrl)!,
                title: "Join Us!"
            )
        }
        .sheet(isPresented: $viewState.showBookClassWebView) {
            WebViewContainer(
                url: URL(string: Constants.JoinNow.PassesUrl)!,
                title: "View Passes"
            )
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
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var greetingView: some View {
        VStack(spacing: 11) {
            Text(viewState.currentGreeting)
                .font(.sfProDisplayBold(size: 35))
                .italic()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 0)
            Text("and welcome to")
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
                title: "Book A Class!",
                onTap: { onAction?(.joinNow) },
                strokeColor: Color.orange.opacity(0.8),
                gradientColor: Color.orange
            )
            ColoredButton(
                title: "View Classes",
                onTap: { onAction?(.viewClasses) },
                strokeColor: Constants.Colors.darkerCyan,
                gradientColor: Constants.Colors.neonCyan
            )
            VStack(spacing: 2) {
                ColoredButton(
                    title: "Passes",
                    onTap: { onAction?(.bookClass) },
                    strokeColor: Constants.Colors.darkerCyan,
                    gradientColor: Constants.Colors.neonCyan
                )
                Text("save money - purchase a pass!")
                    .font(.sfProDisplayRegular(size: 18))
                    .foregroundColor(.gray)
                    .italic()
                    .padding(.top, 0)
            }
            HStack(spacing: 16) {
                HomeRainbowButton(title: "About Us!") { onAction?(.about) }
                HomeRainbowButton(title: "Explore More") {
                    sideDrawerViewModel.openMenu()
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
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
