//
//  HomeView.swift
//  HomeUI
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct HomeView: View {

    let coordinator: SideDrawerCoordinator
    @StateObject private var sideDrawerViewModel: SideDrawerViewModel
    @GestureState private var dragState = DragState.inactive

    enum DragState {
        case inactive
        case dragging(translation: CGFloat)

        var translation: CGFloat {
            switch self {
            case .inactive:
                return 0
            case .dragging(let translation):
                return translation
            }
        }
    }

    enum Action {
    }
    var onAction: ((Action) -> Void)?

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
            .gesture(
                DragGesture(minimumDistance: 30, coordinateSpace: .local)
                    .updating($dragState) { value, state, _ in
                        guard value.startLocation.x < 50 else { return }
                        state = .dragging(translation: value.translation.width)
                    }
                    .onEnded { value in
                        guard value.startLocation.x < 50 else { return }
                        let threshold = Constants.SideDrawer.frameWidth * 0.3
                        if value.translation.width > threshold {
                            sideDrawerViewModel.openMenu()
                        }
                    }
            )

            displaySideDrawerView
        }
    }

    private var displayTopBarView: some View {
        TopBarComponent(viewModel: sideDrawerViewModel)
    }

    private var displaySideDrawerView: some View {
        SideDrawerComponent(viewModel: sideDrawerViewModel)
            .onChange(of: dragState.translation) { _, translation in
                if !sideDrawerViewModel.viewState.isMenuOpen {
                    sideDrawerViewModel.updateDragOffset(CGSize(width: max(0, translation), height: 0))
                }
            }
    }
}
