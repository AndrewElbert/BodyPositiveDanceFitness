//
//  ContactScreen.swift
//  Contact
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactScreen: View {

    @ObservedObject private var viewModel: ContactViewModel

    public init(viewModel: ContactViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        ContactView(
            viewState: $viewModel.viewState,
            onAction: { action in
                switch action {
                case .handleAction(action: let action, title: let title):
                    viewModel.handleAction(action, title: title)
                }
            }
        )
    }
}
