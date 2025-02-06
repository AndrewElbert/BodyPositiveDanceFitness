//
//  ClassesDirector.swift
//  ClassesDirector
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ClassesUI {
    static func classesPage(
    ) -> some View {
        ClassesScreen(
            viewModel: ClassesViewModel(
            )
        )
    }
}
