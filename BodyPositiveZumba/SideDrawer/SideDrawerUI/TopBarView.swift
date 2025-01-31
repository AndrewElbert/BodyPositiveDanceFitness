//
//  TopBarView.swift
//  SideDrawerUI
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
                onAction?(.toggleMenu)
            }) {
                Image(systemName: Constants.Home.buttonImage)
                    .resizable()
                    .frame(width: 24, height: 18)
                    .foregroundColor(.gray)
                    .padding()
            }

            Spacer()
            Image(Constants.Common.logoName)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
