//
//  InitialAppLoadView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI

struct InitialAppLoadView: View {
    
    @State private var initialAppLoadViewModel = InitialAppLoadViewModel()
    
    var body: some View {
        VStack {
            if initialAppLoadViewModel.showHomeScreen {
                HomeView()
            }
            else {
                Image("BodyPositiveLogo")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .scaleEffect(0.8)
            }
        }
    }
}
