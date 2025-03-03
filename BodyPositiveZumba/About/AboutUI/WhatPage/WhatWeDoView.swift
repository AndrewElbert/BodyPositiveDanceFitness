//
//  WhatWeDoView.swift
//  About
//
//  Created by Andrew Elbert on 2/11/25.
//

import SwiftUI

struct WhatWeDoView: View {

    @Environment(\.dismiss) private var dismiss
    @State var viewState: WhatWeDoViewState

    var body: some View {

        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text(Constants.About.whatPageTitle)
                        .underline()
                        .padding(.top, 11)
                        .font(.sfProDisplayBold(size: 38))
                        .fontWeight(.bold)
                        .foregroundColor(.clear)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: Constants.Colors.rainbow),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .mask(
                            Text(Constants.About.whatPageTitle)
                                .font(.sfProDisplayBold(size: 38))
                                .underline()
                                .fontWeight(.bold)
                        )

                    AnimatedLogoView(height: 155)

                    Divider()

                    Text(Constants.About.button2Content)
                        .font(.sfProBodyTextRegular(size: 20))
                        .multilineTextAlignment(.leading)
                        .padding()
                        .opacity(viewState.showContent ? 1 : 0)
                        .animation(.easeIn(duration: 1.5), value: viewState.showContent)
                        .onAppear {
                            viewState.showContent = true
                        }

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
