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
        case viewClasses, about, joinNow, bookClass, photos
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
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                TopBarComponent(viewModel: sideDrawerViewModel)
                VStack(spacing: 16) {
                    Text(viewModel.currentGreeting)
                        .font(.sfProDisplayBold(size: 35))
                        .italic()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                    Text("and welcome to")
                        .font(.sfProDisplayRegular(size: 18))
                        .foregroundColor(.gray)
                        .italic()
                        .padding(.bottom, 6)
                    ZStack {
                        Image(Constants.Common.logoName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .scaleEffect(viewModel.logoScale)
                            .opacity(viewModel.logoOpacity)
                            .offset(y: viewModel.logoOffsetY)
                    }
                    .padding(.bottom, 30)
                    VStack(spacing: 20) {
                        OrangeButton(title: "New? Join Here!") { onAction?(.joinNow) }
                        CyanButton(title: "View Classes") {
                            onAction?(.viewClasses)
                            viewModel.navigateClasses()
                        }
                        CyanButton(title: "Book A Class") { onAction?(.bookClass) }
                        HStack(spacing: 16) {
                            HomeRainbowButton(title: "About Us!") {
                                onAction?(.about)
                                viewModel.navigateAbout()
                            }
                            HomeRainbowButton(title: "Photos!") {
                                onAction?(.photos)
                                viewModel.navigatePhotos()
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .gesture(
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
            )
            SideDrawerComponent(viewModel: sideDrawerViewModel)
                .onChange(of: dragState.translation) { _, translation in
                    if !sideDrawerViewModel.viewState.isMenuOpen {
                        sideDrawerViewModel.updateDragOffset(CGSize(width: max(0, translation), height: 0))
                    }
                }
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
struct GreetingView: View {
    let greetingText: String
    @State private var gradientOffset: CGFloat = -100  // Initial offset value

    var body: some View {
        // Wrap the text in a fixed frame to lock its dimensions.
        Text(greetingText)
            .font(.sfProDisplayBold(size: 35))
            .italic()
            .foregroundColor(.clear) // Hide the base text color.
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 80) // Fixed height to prevent layout shifts.
            .overlay(
                // Animate the gradient's horizontal offset.
                LinearGradient(
                    gradient: Gradient(colors: Constants.Colors.rainbow),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                // Use a fixed frame for the gradient that matches (or exceeds) the text.
                .frame(width: 300, height: 80)
                .offset(x: gradientOffset)
                .mask(
                    Text(greetingText)
                        .font(.sfProDisplayBold(size: 35))
                        .italic()
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(height: 80)
                )
            )
            .onAppear {
                // Animate the offset back and forth without affecting the text layout.
                withAnimation(
                    Animation.linear(duration: 3)
                        .repeatForever(autoreverses: true)
                ) {
                    gradientOffset = 100
                }
            }
    }
}




