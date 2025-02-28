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
                        StaticGradientBackground()
                            .cornerRadius(36)

                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                            .fill((colorScheme == .dark ? Color.black : Color.white).opacity(0.4))

                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                            .stroke(strokeColor, lineWidth: 5)
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

struct StaticGradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Constants.Colors.darkOrange.opacity(0.3),
                .orange.opacity(0.3),
                .yellow.opacity(0.3),
                .green.opacity(0.3),
                .mint.opacity(0.3),
                Constants.Colors.neonCyan.opacity(0.3),
                .teal.opacity(0.3),
                .blue.opacity(0.3),
                .indigo.opacity(0.3),
                .purple.opacity(0.3),
                .pink.opacity(0.3),
                .red.opacity(0.3)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
