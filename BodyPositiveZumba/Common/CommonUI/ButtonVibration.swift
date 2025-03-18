//
//  ButtonVibration.swift
//  Common
//
//  Created by Andrew Elbert on 3/18/25.
//

import Foundation
import SwiftUI

func buttonVibration() {
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    impactFeedback.impactOccurred()
}
