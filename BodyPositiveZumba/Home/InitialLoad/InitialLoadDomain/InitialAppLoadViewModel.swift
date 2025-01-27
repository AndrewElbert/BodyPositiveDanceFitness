//
//  InitialAppLoadViewModel.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

@Observable
class InitialAppLoadViewModel: ObservableObject {
    
    var showHomeScreen = false
    var progress: CGFloat = 0
    var fadeInProgress: Double = 0
    var textColor = Color.cyan
    var barColorStart = Color.cyan
    var barColorEnd = Color.blue
    
    let loadingDuration: Double = 2.2
    
    init() {
        startScreenLoad()
    }
    
    func startLoading() {
        withAnimation {
            progress = 1.0
        }
    }
    
    func startAnimations() {
        withAnimation(Animation.easeIn(duration: 0.8)) {
            fadeInProgress = 1.0
            textColor = Color.blue.opacity(0.9)
        }
        
        withAnimation(Animation.linear(duration: loadingDuration)) {
            barColorStart = Color.cyan.opacity(0.6)
            barColorEnd = Color.blue.opacity(0.9)
        }
    }
    
    private func startScreenLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            self.showHomeScreen = true
        }
    }
}
