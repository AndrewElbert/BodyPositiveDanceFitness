//
//  FaqUI.swift
//  FaqDiretor
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct FaqUI {
    static func faqPage(
    ) -> some View {
        FaqScreen(
            viewModel: FaqViewModel(
            )
        )
    }
}
