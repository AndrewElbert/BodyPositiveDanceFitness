//
//  InitialAppLoadViewModel.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/26/25.
//

import Observation
import SwiftUI

@Observable
class InitialAppLoadViewModel {
    
    var showHomeScreen = false
    var loadingProgress = 0.0
        
    init() {
        startScreenLoad()
    }
    
    private func startScreenLoad() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            self.showHomeScreen = true
        }
    }
}
