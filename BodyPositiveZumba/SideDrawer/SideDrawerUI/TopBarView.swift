//
//  TopBarView.swift
//  SideDrawerUI
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct TopBarView: View {
    let buttonAction: () -> Void
    let logoName: String

    var body: some View {
        HStack {
            Button(action: buttonAction) {
                Image(systemName: Constants.Home.buttonImage)
                    .resizable()
                    .frame(width: 24, height: 18)
                    .foregroundColor(.gray)
                    .padding()
            }

            Spacer()
            Image(logoName)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
