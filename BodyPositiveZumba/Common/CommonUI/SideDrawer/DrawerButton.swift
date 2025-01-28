//
//  DrawerButton.swift
//  CommonUI
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
                        height: Constants.SideDrawer.iconSize)
                    .foregroundColor(Color(white: 0.99))

                Text(title)
                    .font(.system(
                        size: Constants.SideDrawer.fontSize,
                        weight: .bold)
                    )
                    .foregroundColor(Color(white: 0.99))
            }
            .padding(.vertical, 12)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .background(
                RoundedRectangle(cornerRadius: Constants.SideDrawer.cornerRadius)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Constants.SideDrawer.buttonStartColor,
                            Constants.SideDrawer.buttonEndColor
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
            )
            .cornerRadius(Constants.SideDrawer.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.SideDrawer.cornerRadius)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(.horizontal, 10)
            .scaleEffect(1.05)
        }
        .hoverEffect(.highlight)
    }
}
