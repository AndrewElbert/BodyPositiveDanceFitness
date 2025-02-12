//
//  ClassesDirector.swift
//  ClassesDirector
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ClassesUI {

    static func classesPage(
        classesCoordinator: ClassesCoordinator
    ) -> some View {
        ClassesScreen(
            viewModel: ClassesViewModel(
                classesCoordinator: classesCoordinator
            )
        )
    }

    @MainActor static func viewAllClassesPage(
    ) -> some View {
        AllClassesScreen(
            viewModel: AllClassesViewModel()
        )
    }

}
