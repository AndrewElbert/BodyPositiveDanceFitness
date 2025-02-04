//
//  SpaceRentalScreen.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct SpaceRentalScreen: View {

    @ObservedObject private var viewModel: SpaceRentalViewModel

    public init(viewModel: SpaceRentalViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        SpaceRentalView(
            viewState: $viewModel.viewState
        ) { action in
            switch action {
            case .toggleMessage:
                viewModel.toggleMessage()
            }
        }
    }
}
