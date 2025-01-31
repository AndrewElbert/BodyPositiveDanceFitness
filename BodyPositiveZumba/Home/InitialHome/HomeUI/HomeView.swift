//
//  HomeView.swift
//  HomeUI
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct HomeView: View {

    unowned let coordinator: SideDrawerCoordinator
    @StateObject private var sideDrawerViewModel: SideDrawerViewModel

    enum Action {
    }
    var onAction: ((Action) -> Void )?

    public init(
        coordinator: SideDrawerCoordinator,
        onAction: ((Action) -> Void)? = nil
    ) {
        self.coordinator = coordinator
        _sideDrawerViewModel = StateObject(wrappedValue: SideDrawerViewModel(coordinator: coordinator))
        self.onAction = onAction
    }

    var body: some View {
        ZStack {
            VStack {
                 displayTopBarView

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
    private var displayTopBarView: some View {
        TopBarComponent(viewModel: sideDrawerViewModel)
    }

    private var displaySideDrawerView: some View {
        SideDrawerComponent(viewModel: sideDrawerViewModel)
    }
}
