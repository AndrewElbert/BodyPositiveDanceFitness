//
//  TeamScreen.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/9/25.
//

import SwiftUI

struct TeamScreen: View {

    @ObservedObject private var viewModel: TeamViewModel

    public init(viewModel: TeamViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        TeamView(
            viewState: $viewModel.viewState,
            onAction: { action in
                switch action {
                case .toggleBio:
                    viewModel.toggleBioExpanded()
                }
            }
        )
    }
}
