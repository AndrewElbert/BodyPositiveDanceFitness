//
//  ColoredButton.swift
//  Common
//
//  Created by Andrew Elbert on 2/20/25.
//

import SwiftUI

struct ColoredButton: View {
    let title: String
    let action: () -> Void
    let strokeColor: Color
    let gradientColor: Color

    @Environment(\.colorScheme) private var colorScheme
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                isPressed = false
                action()
            }
        }) {
            Text(title)
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .background {
                    ZStack {
                        // The animated background with a rotating gradient and animated dots.
                        CoolAnimatedBackground()
                            .cornerRadius(36)
                        
                        // Semi-transparent base layer for a blended look.
                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                            .fill((colorScheme == .dark ? Color.black : Color.white).opacity(0.4))
                        
                        // An overlay gradient for extra depth.
                        LinearGradient(
                            gradient: Gradient(colors: [
                                gradientColor.opacity(0.1),
                                gradientColor.opacity(0.3)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .cornerRadius(36)
                        
                        // A border stroke.
                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                            .stroke(strokeColor, lineWidth: 3)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                .contentShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
        }
        .buttonStyle(ScaleButtonStyle())
        .frame(height: 60)
        .scaleEffect(isPressed ? 0.97 : 1)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Cool Animated Background

struct CoolAnimatedBackground: View {
    @State private var rotation: Double = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Rotating angular gradient for a vibrant, shifting background.
                AngularGradient(
                    gradient: Gradient(colors: [
                                            .red,
                                            Constants.Colors.darkOrange,
                                            .orange,
                                            .yellow,
                                            .green,
                                            .mint,
                                            Constants.Colors.neonCyan,
                                            .teal,
                                            .blue,
                                            .indigo,
                                            .purple,
                                            .pink,
                                            .red // Loop back to red for continuity
                                        ]),
                    center: .center,
                    angle: .degrees(rotation)
                )
                .animation(Animation.linear(duration: 30).repeatForever(autoreverses: false), value: rotation)
                .onAppear {
                    rotation = 360
                }
                
                // Overlay of animated, pulsating dots.

            }
            .clipped()
        }
    }
}


