//
//  FAQItem.swift
//  FaqUI
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct FaqItem: View {

    let question: String
    let answer: String
    let isExpanded: Bool
    let isClosing: Bool
    let toggleExpanded: () -> Void

    @State private var showText = false

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: toggleExpanded) {
                HStack {
                    Text(question)
                        .font(
                            .system(
                                size: 18,
                                weight: .regular,
                                design: .serif
                            )
                        )
                        .foregroundColor(isExpanded ? Constants.Colors.darkOrange : .primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: Constants.FAQ.chevron)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.none, value: isExpanded)
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            isExpanded ? Color.orange : Constants.Colors.neonCyan,
                            lineWidth: 2
                        )
                )
                .background(
                    RadialGradient(
                        gradient: Gradient(colors: [Constants.Colors.neonCyan.opacity(0.1), Constants.Colors.neonCyan.opacity(0.2)]),
                        center: .center,
                        startRadius: 22,
                        endRadius: 111
                    )
                    .cornerRadius(10)
                )
            }

            ZStack {
                if isExpanded || isClosing {
                    Text(answer)
                        .font(.system(size: 16, weight: .regular, design: .serif))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .opacity(showText ? 1 : 0)
                        .animation(.easeInOut(duration: 0.4), value: showText)
                        .onAppear {
                            showText = true
                        }
                        .onChange(of: isClosing) {
                            if isClosing {
                                showText = false
                            }
                        }
                }
            }
            .frame(maxHeight: isExpanded || isClosing ? nil : 0)
            .animation(.easeInOut(duration: 0.4), value: isExpanded)
        }
    }
}
