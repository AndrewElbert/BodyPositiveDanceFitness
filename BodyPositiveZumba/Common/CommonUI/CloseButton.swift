//
//  CloseButton.swift
//  CommonUI
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct CloseButton: View {
    var dismiss: () -> Void

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.gray)
                        .padding(8)
                }
                .padding(.top, 5)
                .padding(.trailing, 5)
            }
            Spacer()
        }
    }
}
