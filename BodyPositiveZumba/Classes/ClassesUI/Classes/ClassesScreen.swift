//
//  ClassesScreen.swift
//  Classes
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ClassesScreen: View {

    @ObservedObject private var viewModel: ClassesViewModel

    public init(viewModel: ClassesViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        ClassesView(
            viewState: $viewModel.viewState,
            onAction: { action in
                switch action {
                case .handleViewAllButtonTap:
                    viewModel.navigateToViewAll()
                }
            }
        )
    }
}
