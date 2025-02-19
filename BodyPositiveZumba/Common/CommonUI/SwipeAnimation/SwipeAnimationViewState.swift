//
//  SwipeAnimationViewState.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import Foundation

struct SwipeAnimationViewState {

    enum SwipeDirection {
        case right, left
    }

    var isAnimating: Bool = false
    var offset: CGFloat = 0
    var opacity: Double = 0.0
    var swipeDirection: SwipeDirection = .right
}
