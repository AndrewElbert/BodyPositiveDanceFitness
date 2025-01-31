//
//  NewcomersScreen.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct NewcomersScreen: View {

    @ObservedObject private var viewModel: NewcomersViewModel

    public init(viewModel: NewcomersViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        FAQView(
            viewState: $viewModel.viewState
        )
    }
}
