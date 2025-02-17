//
//  SwipeAnimationComponent.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct  SwipeAnimationComponent: View {

    @ObservedObject private var viewModel: SwipeAnimationViewModel

    public init(viewModel: SwipeAnimationViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        SwipeAnimationView(
            viewState: $viewModel.viewState
        )
    }
}
