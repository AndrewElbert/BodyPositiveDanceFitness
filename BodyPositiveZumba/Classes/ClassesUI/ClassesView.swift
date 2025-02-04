//
//  ClassesView.swift
//  ClassesUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct DanceClassCard: View {
    var danceClass: DanceClass
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            Text(danceClass.rawValue)
                .font(.system(size: 20, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)

            if isExpanded {
                Text(danceClass.description)
                    .font(.system(size: 14, design: .serif))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(.opacity)
            } else {
                Text("Tap to learn more")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 5)
            }
        }
        .frame(width: 200, height: 250)
        .background(danceClass.color)
        .cornerRadius(15)
        .shadow(radius: 5)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isExpanded.toggle()
            }
        }
    }
}

struct ClassesView: View {
    
    @State var viewState = SwipableCarouselViewState(items: DanceClass.allCases)
    
    var body: some View {
        SwipableCarouselComponent<AnyView, DanceClass>(
            viewModel: SwipableCarouselViewModel(
                viewState: $viewState
            )
        ) { danceClass, isCurrentCard in
            AnyView(
                DanceClassCard(danceClass: danceClass)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isCurrentCard ? Color.orange : Color.clear, lineWidth: 4)
                    )
                    .shadow(color: isCurrentCard ? Color.orange.opacity(0.3) : Color.clear, radius: 40)
            )
        }
        .frame(height: 400)
    }
}

enum DanceClass: String, CaseIterable, Identifiable {
    case zumbaGold = "Zumba Gold"
    case teal = "Teal"
    case orange = "Orange"
    case shineDance = "Shine Dance"
    case africanHipHop = "African Hip Hop"
    case oula = "Oula"
    case uplift = "Uplift"
    case shineLight = "Shine Light"
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .zumbaGold: return .yellow
        case .teal: return .teal
        case .orange: return .orange
        case .shineDance: return .purple
        case .africanHipHop: return .red
        case .oula: return .blue
        case .uplift: return .green
        case .shineLight: return .pink
        }
    }
    
    var description: String {
        switch self {
        case .zumbaGold: return "A fun, low-impact dance workout perfect for all levels."
        case .teal: return "An energetic class combining various dance styles."
        case .orange: return "A high-energy dance session to uplift your mood."
        case .shineDance: return "A vibrant dance experience celebrating self-expression."
        case .africanHipHop: return "A fusion of African and Hip Hop dance styles."
        case .oula: return "A cardio-dance workout set to motivating music."
        case .uplift: return "A feel-good dance class designed to energize and inspire."
        case .shineLight: return "A gentle and joyful dance class for all levels."
        }
    }
}
    




