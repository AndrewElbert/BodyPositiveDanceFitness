//
//  AllClassesScreen.swift
//  Classes
//
//  Created by Andrew Elbert on 2/12/25.
//

import SwiftUI

struct AllClassesScreen: View {

    @ObservedObject private var viewModel: AllClassesViewModel

    init(
        viewModel: AllClassesViewModel
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        AllClassesView(
            viewState: viewModel.viewState
        )
    }
}
