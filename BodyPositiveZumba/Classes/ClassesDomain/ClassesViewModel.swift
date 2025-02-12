//
//  ClassesViewModel.swift
//  ClassesDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

class ClassesViewModel: ObservableObject {

    @Published var viewState: ClassesViewState = ClassesViewState()
    let classesCoordinator: ClassesCoordinator
    
    init(
        classesCoordinator: ClassesCoordinator
    ) {
        self.classesCoordinator = classesCoordinator
    }

    func toggleExpansion() {
        viewState.isBioExpanded.toggle()
    }
    
    func navigateToViewAll() {
        classesCoordinator.classes_viewAll()
    }
}
