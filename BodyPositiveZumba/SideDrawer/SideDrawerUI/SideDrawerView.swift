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
        case contact
        case signIn
        case subscription
        case endDragGesture
        case closeMenu
        case updateDrag(CGSize)
    }

    @Binding var viewState: SideDrawerViewState
    var onAction: ((Action) -> Void )?
    @State private var newsLetterIsPressed: Bool = false

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

                    DrawerButton(
                        title: Constants.SideDrawer.joinNowText,
                        icon: Constants.SideDrawer.joinNowImage,
                        action: { onAction?(.joinNow) }
                    )

                    DrawerButton(
                        title: Constants.SideDrawer.classesText,
                        icon: Constants.SideDrawer.classesImage,
                        action: { onAction?(.classes) }
                    )

                    DrawerButton(
                        title: Constants.SideDrawer.faqText,
                        icon: Constants.SideDrawer.faqImage,
                        action: { onAction?(.faq) }
                    )

                    DrawerButton(
                        title: Constants.SideDrawer.aboutText,
                        icon: Constants.SideDrawer.aboutImage,
                        action: { onAction?(.about) }
                    )

                    DrawerButton(
                        title: Constants.SideDrawer.contactText,
                        icon: Constants.SideDrawer.contactImage,
                        action: { onAction?(.contact) }
                    )

                    DrawerButton(
                        title: Constants.SideDrawer.signInText,
                        icon: Constants.SideDrawer.signInImage,
                        action: { onAction?(.signIn) }
                    )

                    Divider()
                        .background(Color.gray)

                    VStack(spacing: 16) {
                        Button(action: {

                        }) {
                            HStack {
                                Text(Constants.SideDrawer.newsletterText)
                                    .font(
                                        .system(
                                            size: Constants.SideDrawer.newsLetterFontSize,
                                            weight: .medium,
                                            design: .serif
                                        )
                                    )
                                    .foregroundColor(.black)

                                Image(
                                    systemName: Constants.SideDrawer.newsletterImage
                                )
                                    .foregroundColor(.black)
                                    .frame(
                                        width: Constants.SideDrawer.newsLetterImageSize,
                                        height: Constants.SideDrawer.newsLetterImageSize
                                    )
                            }
                            .padding(.leading, 11)
                            .padding(.trailing, 11)
                            .scaleEffect(newsLetterIsPressed ? Constants.SideDrawer.buttonPressScale : 1.0)
                            .opacity(newsLetterIsPressed ? Constants.SideDrawer.buttonPressOpacity : 1.0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        newsLetterIsPressed = true
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        newsLetterIsPressed = false
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
                .offset(
                    x: viewState.isMenuOpen ?
                        0 : -(Constants.SideDrawer.frameWidth + viewState.dragOffset.width)
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            onAction?(.updateDrag(value.translation))
                        }
                        .onEnded { _ in
                            onAction?(.endDragGesture)
                        }
                )
                .animation(
                    .easeInOut(duration: Constants.SideDrawer.animationDuration),
                    value: viewState.isMenuOpen
                )

                Spacer()
            }
        }
    }
}
