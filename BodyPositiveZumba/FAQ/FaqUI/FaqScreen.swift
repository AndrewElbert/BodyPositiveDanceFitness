//
//  FaqScreen.swift
//  Faq
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct FaqScreen: View {

    @ObservedObject private var viewModel: FaqViewModel

    public init(viewModel: FaqViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        FaqView(
            viewState: $viewModel.viewState,
            onAction: { action in
                switch action {
                case .toggleQuestion(let index):
                    viewModel.toggleQuestion(index)
                }
            }
        )
    }
}
