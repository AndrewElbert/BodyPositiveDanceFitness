//
//  ExpandableSectionComponent.swift
//  SpaceRental
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct ExpandableSectionComponent: View {

    @ObservedObject private var viewModel: ExpandableSectionViewModel

    public init(viewModel: ExpandableSectionViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        ExpandableSection(
            viewState: $viewModel.viewState,
            onAction: { action in
                switch action {
                case .toggleExpansion:
                    viewModel.toggleExpansion()
                }
            }
        )
    }
}
