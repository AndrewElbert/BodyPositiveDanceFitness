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
        case newcomers
        case about
        case contact
        case signIn
        case subscription
    }

    @ObservedObject var viewModel: SideDrawerViewModel
    @State private var newsLetterIsPressed: Bool = false
    
    let menuItems: [SideBarMenuItem]
    var onAction: ActionClosure

    init(
        viewModel: SideDrawerViewModel,
        menuItems: [SideBarMenuItem] = defaultMenuItems,
        onAction: ActionClosure
    ) {
        self.viewModel = viewModel
        self.menuItems = menuItems
        self.onAction = onAction
    }

    private static let defaultMenuItems: [SideBarMenuItem] = [
        SideBarMenuItem(
            title: Constants.SideDrawer.joinNowText,
            icon: Constants.SideDrawer.joinNowImage,
            action: {}),
        SideBarMenuItem(
            title: Constants.SideDrawer.classesText,
            icon: Constants.SideDrawer.classesImage,
            action: {}),
        SideBarMenuItem(
            title: Constants.SideDrawer.faqText,
            icon: Constants.SideDrawer.faqImage,
            action: {}),
        SideBarMenuItem(
            title: Constants.SideDrawer.aboutText,
            icon: Constants.SideDrawer.aboutImage,
            action: {}),
        SideBarMenuItem(
            title: Constants.SideDrawer.contactText,
            icon: Constants.SideDrawer.contactImage,
            action: {}),
        SideBarMenuItem(
            title: Constants.SideDrawer.signInText,
            icon: Constants.SideDrawer.signInImage,
            action: {})
    ]

    var body: some View {
        ZStack {
            Color.black.opacity(
                viewModel.viewState.isMenuOpen ? Constants.SideDrawer.backgroundOpacity : 0
            )
            .ignoresSafeArea()
            .onTapGesture {
                viewModel.closeMenu()
            }
            .animation(
                .easeInOut(duration: Constants.SideDrawer.animationDuration),
                value: viewModel.viewState.isMenuOpen
            )

            HStack {
                VStack(
                    alignment: .leading,
                    spacing: Constants.SideDrawer.buttonSpacing
                ) {
                    Spacer()

                    ForEach(menuItems, id: \.title) { item in
                        DrawerButton(
                            title: item.title,
                            icon: item.icon,
                            action: item.action
                        )
                    }

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
                    x: viewModel.viewState.isMenuOpen ?
                        0 : -(Constants.SideDrawer.frameWidth + viewModel.viewState.dragOffset.width)
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            viewModel.updateDragOffset(value.translation)
                        }
                        .onEnded { _ in
                            viewModel.endDragGesture()
                        }
                )
                .animation(
                    .easeInOut(duration: Constants.SideDrawer.animationDuration),
                    value: viewModel.viewState.isMenuOpen
                )

                Spacer()
            }
        }
    }
}
