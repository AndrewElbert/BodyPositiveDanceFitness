//
//  InitialAppLoadViewState.swift
//  InitialLoadDomain
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct InitialAppLoadViewState {

    var showHomeScreen: Bool = false
    var progress: CGFloat = 0
    var fadeInProgress: Double = 0
    let barLoadDuration: Double = Double.random(in: 0.88...2.22)
    let barLoadPause: Double = 2.0
    let colorChangeDelay: Double = 0.3
    var textColor: Color = .blue
    var barColorStart: Color = .cyan
    var barColorEnd: Color = .blue
    var barOutlineColor: Color = .clear
    var neonCyan: Color = Color(red: 0.0, green: 1.0, blue: 1.0, opacity: 1.0)
}
