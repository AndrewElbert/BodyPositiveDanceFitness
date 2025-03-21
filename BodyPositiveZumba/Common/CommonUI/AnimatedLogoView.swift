//
//  AnimatedLogoView.swift
//  Common
//
//  Created by Andrew Elbert on 3/2/25.
//

import SwiftUI

struct AnimatedLogoView: View {
    
    var height: CGFloat = 222
    @State private var animationComplete = false
    @State private var bounceHeight: CGFloat = 200
    
    var body: some View {
        Image(Constants.Common.logoName)
            .resizable()
            .scaledToFit()
            .frame(height: height)
            .offset(y: animationComplete ? 0 : -bounceHeight)
            .opacity(animationComplete ? 1 : 0)
            .onAppear {
                withAnimation(Animation.spring(
                    response: 0.7,
                    dampingFraction: 0.5, 
                    blendDuration: 0.5
                ).delay(0.4)) {
                    animationComplete = true
                }
            }
    }
}

