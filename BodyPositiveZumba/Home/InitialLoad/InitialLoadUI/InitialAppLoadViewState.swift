//
//  InitialAppLoadViewState.swift
//  Home
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct InitialAppLoadViewState {

    var showHomeScreen: Bool = false
    var progress: CGFloat = 0
    var fadeInProgress: Double = 0
    let barLoadDuration: Double = Double.random(in: 1.33...1.55)
    let barLoadPause: Double = 3.3
    let colorChangeDelay: Double = 0.3
    var textColor: Color = .blue
    var barColorStart: Color = .cyan
    var barColorEnd: Color = .blue
    var barOutlineColor: Color = .clear
    var neonCyan: Color = Constants.Colors.neonCyan
    var endColor: Color = Color(red: 0, green: 0, blue: 0.5)
    var logoShadowOpacity: Double = 0.0
}
