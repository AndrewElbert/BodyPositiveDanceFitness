//
//  WhatWeDoView.swift
//  About
//
//  Created by Andrew Elbert on 2/11/25.
//

import SwiftUI

struct WhatWeDoView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text(Constants.About.whatPageTitle)
                        .padding(.top, 11)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.clear)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: Constants.Colors.rainbow
                                ),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .mask(
                            Text(Constants.About.whatPageTitle)
                                .font(.sfProDisplayBold(size: 32))
                                .fontWeight(.bold)
                        )

                    Text(Constants.About.button2Content)
                        .font(.sfProBodyTextRegular(size: 20))
                        .multilineTextAlignment(.center)
                        .padding()

                    Spacer()
                }
                .padding()
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarButton.closeButton {
                        dismiss()
                    }
                }
                .preferredColorScheme(.light)
            }
        }
    }
}
