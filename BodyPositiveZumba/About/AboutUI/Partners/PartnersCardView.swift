//
//  PartnersCardView.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

struct PartnersCard: View {
    var partner: Partner
    @Binding var viewState: PartnersViewState

    var body: some View {
        VStack {
            logoImage
            Divider()
                .padding(.top, 26)
                .padding(.horizontal, 26)
            websiteButton
        }
        .frame(width: 275, height: 450)
    }
}

private extension PartnersCard {
    var logoImage: some View {
        Image(partner.image)
            .resizable()
            .scaledToFit()
            .frame(width: 240, height: 240)
            .padding(.top, 20)
            //.shadow(color: Constants.Colors.neonCyan.opacity(0.4), radius: 11)
    }
    
    var websiteButton: some View {
        AnimatedGradientButton(action: updateURL)
    }
    
    func updateURL() {
        viewState.displayURL = partner.url
    }
}

struct AnimatedGradientButton: View {
    let action: () -> Void
    @State private var isPressed = false
    @State private var isAnimating = false
    
    private var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: Constants.Colors.rainbow),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { isPressed = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { isPressed = false }
                action()
            }
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }) {
            HStack(spacing: 10) {
                Image(systemName: "globe")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(gradient)
                    .rotationEffect(.degrees(isAnimating ? 15 : -15))
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                    .scaleEffect(isPressed ? 0.9 : 1)
                Text(Constants.Partners.buttonText)
                    .font(.sfProRoundedTextBold(size: 26))
                    .foregroundStyle(gradient)
                    .scaleEffect(isPressed ? 0.95 : 1)
                    .overlay(
                        Text(Constants.Partners.buttonText)
                            .font(.sfProRoundedTextBold(size: 24))
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .opacity(isPressed ? 0.7 : 0)
                    )
                    .underline()
                Image(systemName:  "antenna.radiowaves.left.and.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(gradient)
                    .rotationEffect(.degrees(isAnimating ? 15 : -15))
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                    .scaleEffect(isPressed ? 0.9 : 1)
            }
            .padding(.vertical, 44)
            .contentShape(Rectangle())
            .scaleEffect(isPressed ? 0.97 : 1)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear { isAnimating = true }
    }
}


