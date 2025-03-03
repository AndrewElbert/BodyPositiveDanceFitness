//
//  WhatWeDoViewModel.swift
//  About
//
//  Created by Andrew Elbert on 3/2/25.
//

import SwiftUI

@MainActor
class WhatWeDoViewModel: ObservableObject {

    @Published var viewState: WhatWeDoViewState = WhatWeDoViewState()

}
