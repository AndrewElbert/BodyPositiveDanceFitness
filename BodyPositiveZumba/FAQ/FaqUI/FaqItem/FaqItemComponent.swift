//
//  FaqItemComponent.swift
//  FaqUI
//
//  Created by Andrew Elbert on 1/31/25.
//

 import SwiftUI

 struct FaqItemComponent: View {

    @ObservedObject private var viewModel: FaqItemViewModel

    public init(
        viewModel: FaqItemViewModel
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        FaqItem(
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .toggleExpanded:
                viewModel.toggleExpanded()
            case .handleClosingState:
                viewModel.handleClosingState()
            }
        }
    }
 }
