//
//  AboutScreen.swift
//  AboutUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct AboutScreen: View {

    @ObservedObject private var viewModel: AboutViewModel

    public init(
        viewModel: AboutViewModel
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        AboutView(
            viewState: $viewModel.viewState,
            onAction: { action in
                switch action {
                case .toggleExpansion(let id):
                    viewModel.toggleExpansion(for: id)
                case .handleTeamButtonTap:
                    viewModel.handleTeamButtonTap()
                case .handleClassesButtonTap:
                    viewModel.handleClassesButtonTap()
                case .handlePartnersButtonTap:
                    viewModel.handlePartnersButtonTap()
                }
            }
        )
    }
}
