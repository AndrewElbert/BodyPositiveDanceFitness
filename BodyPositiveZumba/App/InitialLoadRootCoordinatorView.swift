//
//  InitialLoadRootCoordinatorView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/30/25.
//

import FlowStacks
import Foundation
import SwiftUI

struct InitialLoadRootCoordinatorView: View {
    
    @StateObject private var coordinator = InitialLoadRootCoordinator()
    
    var body: some View {
        Router($coordinator.routes) { screen, _ in
            switch screen {
            case .root:
                Text("load screen")
            case .home:
                Text("Home Screen")
            }
        }
    }
}
