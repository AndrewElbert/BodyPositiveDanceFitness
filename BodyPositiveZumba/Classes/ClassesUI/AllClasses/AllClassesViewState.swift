//
//  AllClassesViewState.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/12/25.
//

import SwiftUI

struct AllClassesViewState {

    let classes: [DanceClass]
    var showWebView: Bool = false

    static let current = AllClassesViewState(
        classes: DanceClass.allCases
    )
}
