//
//  MassageScreen.swift
//  Massage
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct MassageScreen: View {

    @ObservedObject private var viewModel: MassageViewModel

    public init(viewModel: MassageViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        MassageView(
            viewState: $viewModel.viewState,
            onAction: { action in
                switch action {
                case .updateUrl:
                    viewModel.updateBookingURL()
                }
            }
        )
    }
}
