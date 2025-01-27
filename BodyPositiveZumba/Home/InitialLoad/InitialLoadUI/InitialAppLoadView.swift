//
//  InitialAppLoadView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct InitialAppLoadView: View {
    
    @State private var initialAppLoadViewModel = InitialAppLoadViewModel()
    @State private var progress: CGFloat = 0
    @State private var fadeInProgress: Double = 0
    @State private var textColor = Color.cyan
    @State private var barColorStart = Color.cyan
    @State private var barColorEnd = Color.blue
    
    let loadingDuration: Double = 2.2
    let fullText = "Are You Ready For The Happiest Workout In Maine?™"
    
    var body: some View {
        VStack {
            if initialAppLoadViewModel.showHomeScreen {
                HomeView()
            } else {
                Image("BodyPositiveLogo")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .scaleEffect(0.9)
                    .padding(.top, 50)
                
                VStack {
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 20)
                        
                        Capsule()
                            .fill(LinearGradient(gradient: Gradient(colors: [barColorStart, barColorEnd]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: progress * UIScreen.main.bounds.width * 0.8, height: 20)
                            .animation(.linear(duration: loadingDuration), value: progress)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    
                    Text(fullText)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .opacity(fadeInProgress)
                        .foregroundColor(textColor)
                        .onAppear {
                            withAnimation(Animation.easeIn(duration: 0.8)) {
                                fadeInProgress = 1.0
                                textColor = Color.blue.opacity(0.9)
                            }
                            withAnimation(Animation.linear(duration: loadingDuration)) {
                                barColorStart = Color.cyan.opacity(0.6)
                                barColorEnd = Color.blue.opacity(0.9)
                            }
                        }
                }
                .onAppear {
                    withAnimation {
                        progress = 1.0
                    }
                }
            }
        }
    }
}

