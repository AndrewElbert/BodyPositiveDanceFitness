//
//  DrawerButton.swift
//  SideDrawer
//
//  Created by Andrew Elbert on 2/4/25.
//

import SwiftUI

struct DrawerButton: View {

    let title: String
    let icon: String?
    let action: () -> Void
    @Binding var isPressed: Bool

    var body: some View {
        
        Button(action: action) {
            HStack(spacing: icon == nil ? 0 : 11) {
                
                if let icon = icon {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: Constants.SideDrawer.sideDrawerButtonImageSize,
                            height: Constants.SideDrawer.sideDrawerButtonImageSize
                        )
                        .foregroundColor(.black)
                }
                Text(title)
                    .font(
                        .sfProRoundedTextBold(
                            size: Constants.SideDrawer.fontSize
                            )
                    )
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .scaleEffect(isPressed ? Constants.SideDrawer.buttonPressScale : 1.0)
            .opacity(isPressed ? Constants.SideDrawer.buttonPressOpacity : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        isPressed = false
                    }
                }
        )
    }
}
