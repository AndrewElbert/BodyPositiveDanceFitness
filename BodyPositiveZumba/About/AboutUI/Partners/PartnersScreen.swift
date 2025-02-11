//
//  PartnersScreen.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

struct PartnersScreen: View {
    
    @ObservedObject private var viewModel: PartnersViewModel
    
    public init(viewModel: PartnersViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        PartnersView(
            viewState: $viewModel.viewState
        )
    }
}
