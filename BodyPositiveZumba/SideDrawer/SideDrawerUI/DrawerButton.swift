//
//  DrawerButton.swift
//  SideDrawerUI
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct DrawerButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(
                        width: Constants.SideDrawer.iconSize,
                        height: Constants.SideDrawer.iconSize
                    )
                    .foregroundColor(.white)

                Text(title)
                    .font(.system(
                        size: Constants.SideDrawer.fontSize,
                        weight: .semibold,
                        design: .default
                    ))
                    .foregroundColor(.white)
            }
            .padding(.vertical, 12)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .background(
                RoundedRectangle(cornerRadius: Constants.SideDrawer.cornerRadius)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.8),
                            Color.gray.opacity(0.5)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
            )
            .cornerRadius(Constants.SideDrawer.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.SideDrawer.cornerRadius)
                    .stroke(Color.white, lineWidth: 1)
            )
            .padding(.horizontal, 10)
            .scaleEffect(1.05)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
        .hoverEffect(.highlight)
    }
}
