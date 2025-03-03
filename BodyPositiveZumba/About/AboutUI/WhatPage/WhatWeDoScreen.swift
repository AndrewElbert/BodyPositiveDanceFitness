//
//  WhatWeDoScreen.swift
//  About
//
//  Created by Andrew Elbert on 2/11/25.
//

import SwiftUI

struct WhatWeDoScreen: View {

    @ObservedObject private var viewModel: WhatWeDoViewModel

    public init(viewModel: WhatWeDoViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        WhatWeDoView(
            viewState: viewModel.viewState
        )
    }
}
