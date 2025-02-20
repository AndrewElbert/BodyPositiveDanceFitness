//
//  SideDrawerView.swift
//  SideDrawer
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

    var body: some View {

        ZStack {
            backgroundOverlay
            drawerContent
        }
        .sheet(isPresented: $viewState.showJoinNowWebView) {
            if let url = URL(string: Constants.JoinNow.joinNowUrl) {
                WebViewContainer(url: url, title: Constants.JoinNow.joinNowTitle)
            }
        }
    }

    private var backgroundOverlay: some View {

        Color.black
            .opacity(viewState.isMenuOpen ? Constants.SideDrawer.backgroundOpacity : 0)
            .ignoresSafeArea()
            .onTapGesture { onAction?(.closeMenu) }
            .animation(.easeInOut(duration: Constants.SideDrawer.animationDuration),
                       value: viewState.isMenuOpen)
    }

    private var drawerContent: some View {

        HStack {
            VStack(alignment: .leading, spacing: Constants.SideDrawer.buttonSpacing) {
                Spacer()
                drawerButtons
                Divider().background(Color.gray)
                contactSection
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
                    .onChanged { value in onAction?(.updateDrag(value.translation)) }
                    .onEnded { _ in onAction?(.endDragGesture) }
            )
            .animation(
                .interpolatingSpring(mass: 1.0,
                                     stiffness: 100,
                                     damping: 16,
                                     initialVelocity: 0),
                value: viewState.dragOffset
            )
            Spacer()
        }
    }

    private var drawerButtons: some View {

        ForEach($viewState.drawerButtons) { $buttonState in
            DrawerButton(
                title: buttonState.title,
                icon: buttonState.icon,
                action: {
                    if buttonState.title == Constants.SideDrawer.joinNowText {
                        viewState.showJoinNowWebView = true
                    } else {
                        onAction?(buttonState.type)
                    }
                },
                isPressed: $buttonState.isPressed
            )
        }
    }

    private var contactSection: some View {

        VStack(spacing: 16) {
            contactButton
            socialButtons
            companyName
        }
        .padding(.bottom, 8)
    }

    private var contactButton: some View {

        Button(action: { onAction?(.contact) }) {
            HStack(spacing: 20) {
                Image(systemName: Constants.SideDrawer.contactImage)
                    .foregroundColor(.black)
                    .frame(width: Constants.SideDrawer.contactImageSize,
                           height: Constants.SideDrawer.contactImageSize)
                    .padding(.bottom, 2)
                Text(Constants.SideDrawer.contactText)
                    .font(.sfProRoundedTextMedium(size: Constants.SideDrawer.contactFontSize))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 11)
            .scaleEffect(viewState.contactIsPressed ? Constants.SideDrawer.buttonPressScale : 1.0)
            .opacity(viewState.contactIsPressed ? Constants.SideDrawer.buttonPressOpacity : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewState.contactIsPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        viewState.contactIsPressed = false
                    }
                }
        )
    }

    private var socialButtons: some View {

        HStack(spacing: 16) {
            socialButton(image: Constants.SideDrawer.facebookLogo, url: Constants.Common.facebookLink)
            socialButton(image: Constants.SideDrawer.youtubeLogo, url: Constants.Common.youtubeLink)
            socialButton(image: Constants.SideDrawer.instagramLogo, url: Constants.Common.instagramLink)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func socialButton(image: String, url: String) -> some View {

        Button(action: {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }) {
            Image(image)
                .resizable()
                .frame(width: 25, height: 25)
        }
    }

    private var companyName: some View {

        Text(Constants.Common.companyName)
            .font(.sfProDisplayRegular(size: Constants.SideDrawer.companyNameFontSize))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
    }

    private func calculateDrawerOffset() -> CGFloat {

        if viewState.isMenuOpen {
            return max(-Constants.SideDrawer.frameWidth,
                       min(0, viewState.dragOffset.width))
        } else {
            return -Constants.SideDrawer.frameWidth +
                max(0, min(Constants.SideDrawer.frameWidth, viewState.dragOffset.width))
        }
    }
}
