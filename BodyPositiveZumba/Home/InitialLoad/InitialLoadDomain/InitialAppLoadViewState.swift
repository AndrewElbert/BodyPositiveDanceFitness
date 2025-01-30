//
//  InitialAppLoadViewState.swift
//  InitialLoad
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct InitialAppLoadViewState {

    var showHomeScreen: Bool = false
    var progress: CGFloat = 0
    var fadeInProgress: Double = 0
    let barLoadDuration: Double = Double.random(in: 0.88...2.22)
    var textColor: Color = .cyan
    var barColorStart: Color = .cyan
    var barColorEnd: Color = .blue
}
