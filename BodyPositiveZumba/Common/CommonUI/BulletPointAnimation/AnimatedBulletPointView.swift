//
//  Animation.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct AnimatedBulletPointView: View {

    enum Action {
        case onAppear
    }

    @Binding var viewState: AnimatedBulletPointViewState
    var onAction: (Action) -> Void

    var body: some View {
        HStack(spacing: 10) {
            emojiView
            textView
        }
        .padding(.vertical, 4)
        .onAppear {
            onAction(.onAppear)
        }
    }

    private var emojiView: some View {
        ZStack {
            Text(viewState.emoji)
                .font(.system(size: 20))
                .opacity(viewState.sparkleOpacity)
                .scaleEffect(viewState.isAnimating ? 1.2 : 0.8)

            Text(viewState.emoji)
                .font(.system(size: 16))
                .opacity(viewState.sparkleOpacity)
                .scaleEffect(viewState.isAnimating ? 0.8 : 1.2)
        }
        .frame(width: 40, alignment: .leading)
    }

    private var textView: some View {
        Text(viewState.text)
            .font(.system(size: 18, design: .serif))
            .foregroundColor(.black.opacity(0.8))
    }
}
