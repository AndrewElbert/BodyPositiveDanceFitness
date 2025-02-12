//
//  SwipeAnimationView.swift
//  CommonUI
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct SwipeAnimationView: View {
    @Binding var viewState: SwipeAnimationViewState

    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 0.0
    @State private var swipeDirection: SwipeDirection = .right

    private enum SwipeDirection {
        case right, left
    }

    var body: some View {
        Image(systemName: "hand.point.up.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .foregroundColor(Constants.Colors.neonCyan.opacity(0.9))
            .offset(x: offset)
            .opacity(opacity)
            .frame(width: 100, height: 50)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    animateCycle()
                }
            }

    }

    func animateCycle() {
        let swipeDistance: CGFloat = 111       // how far to move horizontally
        let fadeInDuration: Double = 0.2        // duration for fading in at the center
        let swipeDuration: Double = 1.1        // duration for the swipe (and fade-out)
        let pauseDuration: Double = 0.5         // pause before the next swipe

        offset = 0
        withAnimation(Animation.linear(duration: fadeInDuration)) {
            opacity = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + fadeInDuration) {
            withAnimation(Animation.linear(duration: swipeDuration)) {
                offset = (swipeDirection == .right) ? swipeDistance : -swipeDistance
                opacity = 0.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + swipeDuration + pauseDuration) {
                swipeDirection = (swipeDirection == .right) ? .left : .right
                animateCycle()
            }
        }
    }
}
