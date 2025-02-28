//
//  SwipeAnimationView.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct SwipeAnimationView: View {

    @Binding var viewState: SwipeAnimationViewState

    var body: some View {
        Image(systemName: "hand.point.up.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 65, height: 65)
            .foregroundColor(Constants.Colors.neonCyan.opacity(0.8))
            .offset(x: viewState.offset)
            .opacity(viewState.opacity)
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

        viewState.offset = 0
        withAnimation(Animation.linear(duration: fadeInDuration)) {
            viewState.opacity = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + fadeInDuration) {
            withAnimation(Animation.linear(duration: swipeDuration)) {
                viewState.offset = (viewState.swipeDirection == .right) ? swipeDistance : -swipeDistance
                viewState.opacity = 0.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + swipeDuration + pauseDuration) {
                viewState.swipeDirection = (viewState.swipeDirection == .right) ? .left : .right
                animateCycle()
            }
        }
    }
}
