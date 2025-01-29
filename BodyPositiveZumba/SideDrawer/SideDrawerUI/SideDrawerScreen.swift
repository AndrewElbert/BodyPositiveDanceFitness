//
//  SideDrawerScreen.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct SideDrawerScreen: View {
    
    @StateObject var viewModel: SideDrawerViewModel
    
    var body: some View {
        SideDrawerView(
            viewModel: viewModel,
            onAction: { action in
                switch action {
                case .joinNow:
                    viewModel.handleAction(.joinNow)
                case .classes:
                    viewModel.handleAction(.classes)
                case .newcomers:
                    viewModel.handleAction(.newcomers)
                case .about:
                    viewModel.handleAction(.about)
                case .contact:
                    viewModel.handleAction(.contact)
                case .signIn:
                    viewModel.handleAction(.signIn)
                case .subscription:
                    viewModel.handleAction(.subscription)
                }
            }
        )
    }
}
