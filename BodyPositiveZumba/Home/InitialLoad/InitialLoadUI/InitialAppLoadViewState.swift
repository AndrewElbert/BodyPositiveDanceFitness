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
    let barLoadDuration: Double = Double.random(in: 0.67...1.33)
    let barLoadPause: Double = 3.3
    let colorChangeDelay: Double = 0.3
    var textColor: Color = .blue
    var barColorStart: Color = .cyan
    var barColorEnd: Color = .blue
    var barOutlineColor: Color = .clear
    var neonCyan: Color = Constants.Colors.neonCyan
}
