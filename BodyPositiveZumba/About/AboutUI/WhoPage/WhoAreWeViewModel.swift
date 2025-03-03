//
//  WhoAreWeViewModel.swift
//  About
//
//  Created by Andrew Elbert on 3/2/25.
//

import SwiftUI

@MainActor
class WhoAreWeViewModel: ObservableObject {

    @Published var viewState: WhoAreWeViewState = WhoAreWeViewState()

}
