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
            .frame(width: 65, height: 65)
            .foregroundColor(.gray.opacity(0.9))
            .offset(x: offset)
            .opacity(opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    animateCycle()
                }
            }

    }

    func animateCycle() {
        let swipeDistance: CGFloat = 190
        let fadeInDuration: Double = 0.2
        let swipeDuration: Double = 1.1
        let pauseDuration: Double = 0.5

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
