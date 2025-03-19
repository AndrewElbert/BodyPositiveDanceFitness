//
//  ButtonVibration.swift
//  Common
//
//  Created by Andrew Elbert on 3/18/25.
//

import Foundation
import SwiftUI

func buttonVibration() {
    
    DispatchQueue.global(qos: .default).async {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
    }
}
