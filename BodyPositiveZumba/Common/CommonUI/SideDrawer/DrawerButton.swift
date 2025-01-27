//
//  DrawerButton.swift
//  CommonUI
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct DrawerButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.vertical, 10)
        }
        .padding(.leading, 20)
    }
}
