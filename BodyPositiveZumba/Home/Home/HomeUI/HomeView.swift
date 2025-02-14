//
//  HomeView.swift
//  HomeUI
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct HomeView: View {
    let coordinator: SideDrawerCoordinator
    @ObservedObject var viewModel: HomeViewModel
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
    
    public init(coordinator: SideDrawerCoordinator, viewModel: HomeViewModel, onAction: ((Action) -> Void)? = nil) {
        self.coordinator = coordinator
        self._sideDrawerViewModel = StateObject(wrappedValue: SideDrawerViewModel(coordinator: coordinator))
        self.viewModel = viewModel
        self.onAction = onAction
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
        .sheet(isPresented: $viewModel.viewState.showJoinWebView) {
            WebViewContainer(
                url: URL(string: Constants.JoinNow.joinNowUrl)!,
                title: "Join Us!"
            )
        }
        .sheet(isPresented: $viewModel.viewState.showBookClassWebView) {
            WebViewContainer(
                url: URL(string: Constants.JoinNow.PassesUrl)!,
                title: "View Passes"
            )
        }
    }
    
    // MARK: - Extracted Subviews for Performance
    
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
            Text(viewModel.viewState.currentGreeting)
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
            OrangeButton(title: "Book A Class!") { onAction?(.joinNow) }
            CyanButton(title: "View Classes") { onAction?(.viewClasses) }
            VStack(spacing: 2) {
                CyanButton(title: "Passes") { onAction?(.bookClass) }
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
    
    // MARK: - Helper Methods
    
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

// Rainbow Button Style (copied from AboutView and modified)
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

// Cyan Button Style (inspired by ActionButton from AboutView)
struct CyanButton: View {
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(buttonBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Constants.Colors.darkerCyan, lineWidth: 8)
                )
                .cornerRadius(8)
        }
    }

    private var buttonBackground: some View {
        ZStack {
            Color.white
            RadialGradient(
                gradient: Gradient(colors: [
                    Constants.Colors.neonCyan.opacity(0.05),
                    Constants.Colors.neonCyan.opacity(0.2)
                ]),
                center: .center,
                startRadius: 55,
                endRadius: 122
            )
        }
    }
}

// Orange Button Style (based on CyanButton but with orange colors)
struct OrangeButton: View {
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.sfProRoundedTextSemibold(size: 22))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(buttonBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.orange.opacity(0.8), lineWidth: 8)
                )
                .cornerRadius(8)
        }
    }

    private var buttonBackground: some View {
        ZStack {
            Color.white
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.orange.opacity(0.05),
                    Color.orange.opacity(0.2)
                ]),
                center: .center,
                startRadius: 55,
                endRadius: 122
            )
        }
    }
}




