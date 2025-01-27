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
                        Image(systemName: "line.horizontal.3")
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
                        Text("Welcome to Body Positive Dance Fitness")
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

            Color.black.opacity(viewModel.viewState.isMenuOpen ? 0.5 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.closeMenu()
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.viewState.isMenuOpen)

            HStack {
                VStack(alignment: .leading) {
                    DrawerButton(title: "About", action: {})
                    DrawerButton(title: "Classes", action: {})
                    DrawerButton(title: "Newcomers/FAQ", action: {})
                    DrawerButton(title: "Sign In", action: {})
                    Spacer()
                }
                .frame(width: 250)
                .background(Color.white)
                .offset(x: viewModel.viewState.isMenuOpen ? 0 : -250 + viewModel.viewState.dragOffset.width)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            viewModel.updateDragOffset(value.translation)
                        }
                        .onEnded { _ in
                            viewModel.endDragGesture()
                        }
                )
                .animation(.easeInOut(duration: 0.3), value: viewModel.viewState.isMenuOpen)

                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
