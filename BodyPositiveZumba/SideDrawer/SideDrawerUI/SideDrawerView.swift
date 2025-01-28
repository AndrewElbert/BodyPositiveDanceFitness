//
//  SideDrawerView.swift
//  SideDrawerUI
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct SideDrawerView: View {
    @ObservedObject var viewModel: SideDrawerViewModel
    let menuItems: [SideBarMenuItem]

    init(viewModel: SideDrawerViewModel, menuItems: [SideBarMenuItem] = defaultMenuItems) {
        self.viewModel = viewModel
        self.menuItems = menuItems
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
            title: Constants.SideDrawer.signInText,
            icon: Constants.SideDrawer.signInImage,
            action: {}),
        SideBarMenuItem(
            title: Constants.SideDrawer.contactText,
            icon: Constants.SideDrawer.contactImage,
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
                        startRadius: 44,
                        endRadius: 444
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
