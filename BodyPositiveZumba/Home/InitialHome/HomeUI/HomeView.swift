//
//  HomeView.swift
//  InitialHome
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        viewModel.toggleMenu()
                    }) {
                        Image(systemName: Constants.Home.buttonImage)
                            .resizable()
                            .frame(width: 24, height: 18)
                            .foregroundColor(.gray)
                            .padding()
                    }

                    Spacer()
                    Image(Constants.Common.logoName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                ScrollView {
                    VStack {
                        Text(Constants.Home.grettingMessage)
                            .font(.largeTitle)
                            .bold()
                            .padding()

                        ForEach(0..<20, id: \.self) { item in
                            Text("Scrollable Content \(item + 1)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
            }

            Color.black.opacity(
                viewModel.viewState.isMenuOpen ? Constants.SideDrawer.backgroundOpacity : 0
            )
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.closeMenu()
                }
                .animation(
                    .easeInOut(duration: Constants.SideDrawer.animationDuration),
                    value: viewModel.viewState.isMenuOpen)

            HStack {
                VStack(
                    alignment: .leading, spacing: Constants.SideDrawer.buttonSpacing) {
                    Spacer()
                    DrawerButton(
                        title: Constants.SideDrawer.joinNowText,
                        icon: Constants.SideDrawer.joinNowImage,
                        action: {})
                    DrawerButton(
                        title: Constants.SideDrawer.classesText,
                        icon: Constants.SideDrawer.classesImage,
                        action: {
                        })
                    DrawerButton(
                        title: Constants.SideDrawer.faqText,
                        icon: Constants.SideDrawer.faqImage,
                        action: {
                        })
                    DrawerButton(
                        title: Constants.SideDrawer.aboutText,
                        icon: Constants.SideDrawer.aboutImage,
                        action: {
                        })
                    DrawerButton(
                        title: Constants.SideDrawer.signInText,
                        icon: Constants.SideDrawer.signInImage,
                        action: {
                        })
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
                    value: viewModel.viewState.isMenuOpen)

                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
