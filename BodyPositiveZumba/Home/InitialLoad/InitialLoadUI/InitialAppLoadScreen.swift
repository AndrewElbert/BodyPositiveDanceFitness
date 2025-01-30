//
//  InitialAppLoadScreen.swift
//  InitialLoadUI
//
//  Created by Andrew Elbert on 1/30/25.
//

import SwiftUI

struct InitialAppLoadScreen: View {

    @StateObject private var viewModel: InitialAppLoadViewModel

    public init(viewModel: InitialAppLoadViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        InitialAppLoadView(
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .navigateHomeScreen:
                viewModel.navigateToHomeScreen()
            case .startLoading:
                viewModel.startLoading()
            case .startAnimations:
                viewModel.startAnimations()
            }
        }
    }
}
