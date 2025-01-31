//
//  SideDrawerScreen.swift
//  SideDrawerUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct SideDrawerComponent: View {

    @ObservedObject private var viewModel: SideDrawerViewModel

    public init(viewModel: SideDrawerViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        SideDrawerView(
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .joinNow:
                viewModel.navigateJoinNow()
            case .classes:
                viewModel.navigateClasses()
            case .newcomers:
                viewModel.navigateNewcomers()
            case .about:
                viewModel.navigateAbout()
            case .contact:
                viewModel.navigateContact()
            case .signIn:
                viewModel.navigateSignIn()
            case .subscription:
                viewModel.navigateSubscription()
            case .endDragGesture:
                viewModel.endDragGesture()
            case .closeMenu:
                viewModel.closeMenu()
            case .updateDrag(let offset):
                viewModel.updateDragOffset(offset)
            }
        }
    }
}
