//
//  AnimatedBulletPointComponent.swift
//  Common
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedBulletPointComponent: View {

    @ObservedObject private var viewModel: AnimatedBulletPointViewModel

    init(viewModel: AnimatedBulletPointViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        AnimatedBulletPointView(viewState: $viewModel.viewState) { action in
            switch action {
            case .onAppear:
                viewModel.startAnimation()
            }
        }
    }
}
