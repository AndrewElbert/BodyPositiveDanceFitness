//
//  ClassesViewModel.swift
//  ClassesDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

class ClassesViewModel: ObservableObject {

    @Published var viewState: ClassesViewState = ClassesViewState()

    func toggleExpansion() {
        viewState.isBioExpanded.toggle()
    }
}
