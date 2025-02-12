//
//  AllClassesViewState.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/12/25.
//

import SwiftUI

struct AllClassesViewState {
    
    let classes: [DanceClass]
    let isLoading: Bool
    
    static let current = AllClassesViewState(
        classes: DanceClass.allCases,
        isLoading: false
    )
}
