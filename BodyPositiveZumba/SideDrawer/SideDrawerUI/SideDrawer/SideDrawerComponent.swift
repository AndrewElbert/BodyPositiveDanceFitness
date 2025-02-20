//
//  SideDrawerScreen.swift
//  SideDrawer
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
            case .classes:
                viewModel.navigateClasses()
            case .faq:
                viewModel.navigateFaq()
            case .about:
                viewModel.navigateAbout()
            case .massage:
                viewModel.navigateMassage()
            case .spaceRental:
                viewModel.navigatespaceRental()
            case .contact:
                viewModel.navigateContact()
            case .endDragGesture:
                viewModel.endDragGesture()
            case .closeMenu:
                viewModel.closeMenu()
            case .updateDrag(let offset):
                viewModel.updateDragOffset(offset)
            case .joinNow:
                // intentionally blank
                break
            }
        }
    }
}
