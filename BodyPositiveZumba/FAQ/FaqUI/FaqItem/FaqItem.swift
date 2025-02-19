//
//  FAQItem.swift
//  Faq
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct FaqItem: View {
    
    enum Action {
        case toggleExpanded
        case handleClosingState
    }

    @Binding var viewState: FaqItemViewState
    var onAction: ((Action) -> Void)?
    @Environment(\.colorScheme) private var colorScheme

    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }

    private var borderColor: Color {
        viewState.isExpanded ? Color.orange : Constants.Colors.neonCyan
    }

    private var backgroundView: some View {
        ZStack {
            Color(.white)
            RadialGradient(
                gradient: Gradient(colors: [
                    Constants.Colors.neonCyan.opacity(0.1),
                    Constants.Colors.neonCyan.opacity(0.3)
                ]),
                center: .center,
                startRadius: 22,
                endRadius: 122
            )
        }
        .cornerRadius(10)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                onAction?(.toggleExpanded)
            } label: {
                HStack {
                    Text(viewState.question)
                        .font(.sfProRoundedTextRegular(size: 18))
                        .foregroundColor(viewState.isExpanded ? Constants.Colors.darkOrange : .black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: Constants.FAQ.chevron)
                        .rotationEffect(.degrees(viewState.isExpanded ? 180 : 0))
                        .animation(.none, value: viewState.isExpanded)
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 2)
                )
                .background(backgroundView)
            }

            ZStack {
                if viewState.isExpanded || viewState.isClosing {
                    Text(viewState.answer)
                        .font(.sfProBodyTextRegular(size: 18))
                        .foregroundColor(adaptiveTextColor)
                        .padding()
                        .cornerRadius(10)
                }
            }
            .frame(maxHeight: viewState.isExpanded ? nil : 0)
            .clipped()
            .animation(viewState.isExpanded ? .smooth(duration: 0.88) : .none, value: viewState.isExpanded)
            .onChange(of: viewState.showText) { _, newValue in
                if !newValue && !viewState.isExpanded {
                    DispatchQueue.main.async {
                        viewState.isClosing = false
                    }
                }
            }
        }
    }
}

