//
//  TopBarView.swift
//  SideDrawer
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct TopBarView: View, ActionableView {

    enum Action {
        case toggleMenu
    }

    var onAction: ((Action) -> Void )?

    public init(
        onAction: ( (Action) -> Void)? = nil
    ) {
        self.onAction = onAction
    }

    var body: some View {
        HStack {
            Button(action: {
                buttonVibration()
                onAction?(.toggleMenu)
            }) {
                Image(systemName: Constants.Home.buttonImage)
                    .resizable()
                    .frame(width: 24, height: 18)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
