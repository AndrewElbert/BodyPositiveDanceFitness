//
//  AnimatedLogoView.swift
//  Common
//
//  Created by Andrew Elbert on 3/2/25.
//

import SwiftUI

struct AnimatedLogoView: View {

    var height: CGFloat = 222
    @State private var animateLogo = false

    var body: some View {
        Image(Constants.Common.logoName)
            .resizable()
            .scaledToFit()
            .frame(height: height)
            .scaleEffect(animateLogo ? 1 : 0.5)
            .rotationEffect(.degrees(animateLogo ? 0 : -222))
            .opacity(animateLogo ? 1 : 0)
            .shadow(color: .gray.opacity(animateLogo ? 0.5 : 0), radius: animateLogo ? 10 : 0, x: 0, y: animateLogo ? 10 : 0)
            .onAppear {
                withAnimation(Animation.interpolatingSpring(stiffness: 70, damping: 8).delay(0.3)) {
                    animateLogo = true
                }
            }
    }
}
