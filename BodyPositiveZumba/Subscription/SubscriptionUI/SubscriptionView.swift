//
//  SubscriptionView.swift
//  SubscriptionUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct SubscriptionView: View {

    @StateObject private var subscriptionViewModel = SubscriptionViewModel()
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
            SideDrawerView(viewModel: sideDrawerViewModel)
        }
    }
}

#Preview {
    HomeView()
}
