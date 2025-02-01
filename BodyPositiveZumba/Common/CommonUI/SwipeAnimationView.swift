//
//  SwipeAnimationView.swift
//  CommonUI
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct SwipeAnimationView: View {
    @Binding var isAnimating: Bool

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Image(systemName: "hand.point.left.fill")
                    .offset(x: isAnimating ? -10 : 0)
                    .opacity(isAnimating ? 0 : 1)

                Image(systemName: "arrow.left")
                    .offset(x: isAnimating ? -10 : 0)
                    .opacity(isAnimating ? 1 : 0)
            }

            ZStack {
                Image(systemName: "hand.point.right.fill")
                    .offset(x: isAnimating ? 10 : 0)
                    .opacity(isAnimating ? 0 : 1)

                Image(systemName: "arrow.right")
                    .offset(x: isAnimating ? 10 : 0)
                    .opacity(isAnimating ? 1 : 0)
            }
        }
        .font(.system(size: 24))
        .foregroundColor(.gray)
        .frame(width: 120, height: 30)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}
