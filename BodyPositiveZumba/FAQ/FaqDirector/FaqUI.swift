//
//  FaqUI.swift
//  Faq
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct FaqUI {
    
    @MainActor static func faqPage(
    ) -> some View {
        FaqScreen(
            viewModel: FaqViewModel(
            )
        )
    }
}
