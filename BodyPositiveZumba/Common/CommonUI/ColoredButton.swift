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
                .font(.sfProRoundedTextMedium(size: 22))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(colorScheme == .dark ? .black : .white)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        LinearGradient(
                            gradient: Gradient(colors: [
                                gradientColor.opacity(0.01),
                                gradientColor.opacity(0.95)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(strokeColor, lineWidth: 6)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
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
