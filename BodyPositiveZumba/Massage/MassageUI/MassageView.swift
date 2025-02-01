//
//  MassageView.swift
//  MassageUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI
import UIKit
import WebKit

struct BookingURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct MassageView: View {
    let cardsData: [CardModel] = [
        CardModel(
            id: UUID(),
            name: Constants.HeadShots.LindseyHerseyName,
            imageName: Constants.HeadShots.LindseyHerseyHeadShot,
            parlor: Constants.Massage.LindseyHerseyParlor,
            bio: Constants.Massage.LindseyHerseyBio
        ),
        CardModel(
            id: UUID(),
            name: Constants.HeadShots.ShelbySwannName,
            imageName: Constants.HeadShots.ShelbySwannHeadShot,
            parlor: Constants.Massage.ShelbySwannParlor,
            bio: Constants.Massage.ShelbySwannBio
        )
    ]
    
    @Environment(\.dismiss) var dismiss
    @State private var currentIndex: Int = 0
    @State private var isAnimating = false
    @State private var isCardExpanded = false
    @State private var bookingURL: BookingURL?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Text(Constants.Massage.pageTitle)
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text(Constants.Massage.pageBio)
                    .font(.system(size: 16, design: .serif))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                
                InfiniteCarouselView(items: cardsData,
                                       currentIndex: $currentIndex,
                                       spacing: 10,
                                       sideSpacing: 40) { card, isCurrentCard in
                    SwipableCardView(card: card)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isCurrentCard ? Color.orange : Color.clear, lineWidth: 3)
                        )
                        .shadow(color: isCurrentCard ? Color.orange.opacity(0.3) : Color.clear, radius: 10)
                }
                .frame(height: 400)
                
                VStack(spacing: 8) {
                    Text("Swipe")
                        .font(.system(size: 16, weight: .medium, design: .serif))
                        .foregroundColor(.gray)
                    
                    SwipeAnimationView(isAnimating: $isAnimating)
                }
                .padding(.top, 60)
                .padding(.bottom, 15)

                Button(action: {
                    let normalizedIndex = ((currentIndex % cardsData.count) + cardsData.count) % cardsData.count
                    
                    var urlString: String = ""
                    if normalizedIndex == 0 {
                        urlString = "https://ladyloveholistics.com/"
                    } else {
                        urlString = "https://swanns-healing-elements.square.site/"
                    }
                    
                    if let url = URL(string: urlString) {
                        bookingURL = BookingURL(url: url)
                    }
                }) {
                    Text("Book Today!")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Constants.Colors.neonCyan.opacity(0.1),
                                    Constants.Colors.neonCyan.opacity(0.2)
                                ]),
                                center: .center, startRadius: 5, endRadius: 50
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.orange, lineWidth: 2)
                        )
                        .cornerRadius(8)
                }
                .padding(.top, 2)
            }
            
            CloseButton(dismiss: {
                dismiss()
            })
        }
        .sheet(item: $bookingURL) { booking in
            WebView(url: booking.url)
                .overlay(
                    CloseButton(dismiss: {
                        dismiss()
                    }))
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SwipeAnimationView: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Image(systemName: "hand.point.left.fill")
                    .offset(x: isAnimating ? -10 : 0)
                    .opacity(isAnimating ? 0 : 1)
                
                Image(systemName: "arrow.left")
                    .offset(x: isAnimating ? -10 : 0)
                    .opacity(isAnimating ? 1 : 0)
            }
            
            ZStack {
                Image(systemName: "hand.point.right.fill")
                    .offset(x: isAnimating ? 10 : 0)
                    .opacity(isAnimating ? 0 : 1)
                
                Image(systemName: "arrow.right")
                    .offset(x: isAnimating ? 10 : 0)
                    .opacity(isAnimating ? 1 : 0)
            }
        }
        .font(.system(size: 24))
        .foregroundColor(.gray)
        .frame(width: 120, height: 30)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

struct InfiniteCarouselView<Content: View, T: Identifiable>: View {
    var items: [T]
    @Binding var currentIndex: Int
    var spacing: CGFloat = 10
    var sideSpacing: CGFloat = 40
    var content: (T, Bool) -> Content
    
    private var circularItems: [T] {
        guard let first = items.first, let last = items.last else { return items }
        return [last] + items + [first]
    }
    
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let cardWidth = max(0, proxy.size.width - (sideSpacing * 2))
            let cardWithSpacing = cardWidth + spacing
            let displayIndex = CGFloat(currentIndex + 1)
            
            HStack(spacing: spacing) {
                ForEach(Array(circularItems.enumerated()), id: \.offset) { index, item in
                    content(item, index == currentIndex + 1)
                        .frame(width: cardWidth)
                }
            }
            .offset(x: sideSpacing - (displayIndex * cardWithSpacing) + dragOffset)
            .animation(.easeInOut, value: dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = cardWidth / 2
                        var newIndex = currentIndex
                        if value.translation.width < -threshold {
                            newIndex += 1
                        } else if value.translation.width > threshold {
                            newIndex -= 1
                        }
                        withAnimation(.easeInOut) {
                            currentIndex = newIndex
                        }
                    }
            )
            .onChange(of: currentIndex) { oldValue, newValue in
                if newValue < 0 {
                    DispatchQueue.main.async {
                        withAnimation(.none) {
                            currentIndex = items.count - 1
                        }
                    }
                } else if newValue >= items.count {
                    DispatchQueue.main.async {
                        withAnimation(.none) {
                            currentIndex = 0
                        }
                    }
                }
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
