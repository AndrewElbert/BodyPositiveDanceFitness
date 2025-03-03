//
//  WhoAreWeComponent.swift
//  About
//
//  Created by Andrew Elbert on 2/11/25.
//

import SwiftUI

struct WhoAreWeScreen: View {

    @ObservedObject private var viewModel: WhoAreWeViewModel

    public init(viewModel: WhoAreWeViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        WhoAreWeView(
            viewState: viewModel.viewState
        )
    }
}
