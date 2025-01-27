//
//  InitialAppLoadView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct InitialAppLoadView: View {
    
    @StateObject private var viewModel = InitialAppLoadViewModel()
    
    let fullText = "Are You Ready For The Happiest Workout In Maine?™"
    
    var body: some View {
        VStack {
            if viewModel.showHomeScreen {
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
                            .fill(LinearGradient(gradient: Gradient(colors: [viewModel.barColorStart, viewModel.barColorEnd]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: viewModel.progress * UIScreen.main.bounds.width * 0.8, height: 20)
                            .animation(.linear(duration: viewModel.loadingDuration), value: viewModel.progress)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    
                    Text(fullText)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .opacity(viewModel.fadeInProgress)
                        .foregroundColor(viewModel.textColor)
                        .onAppear {
                            viewModel.startAnimations()
                        }
                }
                .onAppear {
                    viewModel.startLoading()
                }
            }
        }
    }
}
