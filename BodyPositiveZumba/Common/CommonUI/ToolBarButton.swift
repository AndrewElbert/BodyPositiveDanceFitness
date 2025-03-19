//
//  ToolbarButton.swift
//  Common
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct ToolbarButton: ToolbarContent {

    @Environment(\.colorScheme) private var colorScheme

    var icon: String
    var size: CGFloat
    var color: ButtonColor
    var placement: ToolbarItemPlacement
    var action: () -> Void

    enum ButtonColor {
        case system
        case accent
        case destructive
        case custom(light: Color, dark: Color)

        func color(for colorScheme: ColorScheme) -> Color {
            switch self {
            case .system:
                return colorScheme == .dark ? .gray : .gray.opacity(0.8)
            case .accent:
                return .accentColor
            case .destructive:
                return .red
            case .custom(let light, let dark):
                return colorScheme == .dark ? dark : light
            }
        }
    }

    init(
        icon: String = "xmark",
        size: CGFloat = 20,
        color: ButtonColor = .system,
        placement: ToolbarItemPlacement = .navigationBarTrailing,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.color = color
        self.placement = placement
        self.action = action
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: {
                buttonVibration()
                action()
            }) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundColor(color.color(for: colorScheme))
            }
        }
    }
}

extension ToolbarButton {
    static func closeButton(action: @escaping () -> Void) -> ToolbarButton {
        ToolbarButton(
            icon: "xmark",
            size: 18,
            color: .system,
            action: action
        )
    }

    static func backButton(
        action: @escaping () -> Void
    ) -> ToolbarButton {
            ToolbarButton(
                icon: "chevron.backward",
                size: 21,
                color: .accent,
                placement: .navigationBarLeading
            ) {
                withAnimation(.easeOut(duration: 0.2)) {
                    action()
                }
            }
        }

    static func addButton(action: @escaping () -> Void) -> ToolbarButton {
        ToolbarButton(
            icon: "plus.circle.fill",
            size: 22,
            color: .accent,
            action: action
        )
    }

    static func deleteButton(action: @escaping () -> Void) -> ToolbarButton {
        ToolbarButton(
            icon: "trash",
            size: 22,
            color: .destructive,
            action: action
        )
    }
}
