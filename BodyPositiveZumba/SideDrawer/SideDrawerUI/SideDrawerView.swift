//
//  SideDrawerView.swift
//  SideDrawerUI
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct SideDrawerView: View, ActionableView {
    
    enum Action {
        case joinNow
        case classes
        case faq
        case about
        case massage
        case spaceRental
        case contact
        case endDragGesture
        case closeMenu
        case updateDrag(CGSize)
    }

    @Binding var viewState: SideDrawerViewState
    var onAction: ((Action) -> Void)?

    public init(
        viewState: Binding<SideDrawerViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        ZStack {
            Color.black.opacity(
                viewState.isMenuOpen ? Constants.SideDrawer.backgroundOpacity : 0
            )
            .ignoresSafeArea()
            .onTapGesture {
                onAction?(.closeMenu)
            }
            .animation(
                .easeInOut(duration: Constants.SideDrawer.animationDuration),
                value: viewState.isMenuOpen
            )

            HStack {
                VStack(
                    alignment: .leading,
                    spacing: Constants.SideDrawer.buttonSpacing
                ) {
                    Spacer()

                    ForEach($viewState.drawerButtons) { $buttonState in
                        DrawerButton(
                            title: buttonState.title,
                            icon: buttonState.icon,
                            action: {
                                onAction?(buttonState.type)
                            },
                            isPressed: $buttonState.isPressed
                        )
                    }

                    Divider()
                        .background(Color.gray)

                    VStack(spacing: 16) {
                        Button(action: {
                            onAction?(.contact)
                        }) {
                            HStack(spacing: 4) {
                                Text(Constants.SideDrawer.newsletterText)
                                    .font(
                                        .system(
                                            size: Constants.SideDrawer.newsLetterFontSize,
                                            weight: .medium,
                                            design: .serif
                                        )
                                    )
                                    .foregroundColor(.black)

                                Image(systemName: Constants.SideDrawer.newsletterImage)
                                    .foregroundColor(.black)
                                    .frame(
                                        width: Constants.SideDrawer.newsLetterImageSize,
                                        height: Constants.SideDrawer.newsLetterImageSize
                                    )
                            }
                            .padding(.leading, 11)
                            .padding(.trailing, 11)
                            .scaleEffect(viewState.newsLetterIsPressed ? Constants.SideDrawer.buttonPressScale : 1.0)
                            .opacity(viewState.newsLetterIsPressed ? Constants.SideDrawer.buttonPressOpacity : 1.0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        viewState.newsLetterIsPressed = true
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        viewState.newsLetterIsPressed = false
                                    }
                                }
                        )

                        HStack(spacing: 16) {
                            Button(action: {
                                if let url = URL(string: Constants.Common.facebookLink) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Image(Constants.SideDrawer.facebookLogo)
                            }
                            Button(action: {
                                if let url = URL(string: Constants.Common.instagramLink) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Image(Constants.SideDrawer.instagramLogo)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                        Text(Constants.Common.companyName)
                            .font(
                                .system(
                                    size: Constants.SideDrawer.companyNameFontSize,
                                    weight: .thin,
                                    design: .serif
                                )
                            )
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 10)
                    }
                    .padding(.bottom, 8)

                    Spacer()
                }
                .frame(width: Constants.SideDrawer.frameWidth)
                .background(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Constants.SideDrawer.innerCircleColorRadius,
                            Constants.SideDrawer.outerCircleColorRadius
                        ]),
                        center: .center,
                        startRadius: Constants.SideDrawer.startRadius,
                        endRadius: Constants.SideDrawer.endRadius
                    )
                )
                .offset(x: calculateDrawerOffset())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            onAction?(.updateDrag(value.translation))
                        }
                        .onEnded { _ in
                            onAction?(.endDragGesture)
                        }
                )
                .animation(
                    .interpolatingSpring(
                        mass: 1.0,
                        stiffness: 100,
                        damping: 16,
                        initialVelocity: 0
                    ),
                    value: viewState.dragOffset
                )

                Spacer()
            }
        }
    }
    
    private func calculateDrawerOffset() -> CGFloat {
        if viewState.isMenuOpen {
            return max(-Constants.SideDrawer.frameWidth, min(0, viewState.dragOffset.width))
        } else {
            return -Constants.SideDrawer.frameWidth + max(0, min(Constants.SideDrawer.frameWidth, viewState.dragOffset.width))
        }
    }
}

