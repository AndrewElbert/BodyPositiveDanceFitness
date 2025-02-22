//
//  ClassesDirector.swift
//  Classes
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ClassesUI {

    @MainActor static func classesPage(
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
