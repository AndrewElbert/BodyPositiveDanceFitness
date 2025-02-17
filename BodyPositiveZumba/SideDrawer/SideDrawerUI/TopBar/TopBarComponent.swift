//
//  TopBarComponent.swift
//  SideDrawer
//
//  Created by Andrew Elbert on 1/30/25.
//

import SwiftUI

struct TopBarComponent: View {

    @ObservedObject private var viewModel: SideDrawerViewModel

    public init(viewModel: SideDrawerViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        TopBarView { action in
            switch action {
            case .toggleMenu:
                viewModel.openMenu()
            }
        }
    }
}
