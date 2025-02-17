//
//  AllClassesViewModel.swift
//  Classes
//
//  Created by Andrew Elbert on 2/12/25.
//

import SwiftUI

@MainActor
final class AllClassesViewModel: ObservableObject {

    @Published var viewState: AllClassesViewState = .current

}
