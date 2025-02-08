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

    @Environment(\.colorScheme) private var colorScheme
    @Binding var viewState: AnimatedBulletPointViewState
    var onAction: (Action) -> Void
    
    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

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
                .font(.system(size: 12 ))
                .opacity(viewState.sparkleOpacity)
                .scaleEffect(viewState.isAnimating ? 0.8 : 1.2)
        }
        .frame(width: 40, alignment: .leading)
    }

    private var textView: some View {
        Text(viewState.text)
            .font(.sfProBodyTextRegular(size: 18))
            .foregroundColor(adaptiveTextColor.opacity(0.8))
    }
}
