//
//  SwipeAnimationView.swift
//  CommonUI
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI

struct SwipeAnimationView: View {

    @Binding var viewState: SwipeAnimationViewState

    public init(
        viewState: Binding<SwipeAnimationViewState>
    ) {
        self._viewState = viewState
    }

    var body: some View {
        ZStack {
            Image(systemName: "hand.point.right.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.gray.opacity(0.8))
                .offset(x: viewState.isAnimating ? 30 : -30)
                .opacity(viewState.isAnimating ? 1 : 0.3)
                .animation(
                    Animation.easeInOut(duration: 1.8)
                        .repeatForever(autoreverses: true),
                    value: viewState.isAnimating
                )
                .rotationEffect(.degrees(viewState.isAnimating ? 10 : -10))
        }
        .frame(width: 100, height: 50)
        .onAppear {
            viewState.isAnimating = true
        }
    }
}
