//
//  HomeView.swift
//  InitialHome
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var sideDrawerViewModel = SideDrawerViewModel()

    var body: some View {
        ZStack {
            VStack {
                TopBarView(buttonAction: {
                    sideDrawerViewModel.toggleMenu()
                }, logoName: Constants.Common.logoName)

                // Main content
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
            displaySideDrawerView
        }
    }

    private var displaySideDrawerView: some View {
        SideDrawerComponent(viewModel: sideDrawerViewModel)
    }
}

#Preview {
    HomeView()
}
