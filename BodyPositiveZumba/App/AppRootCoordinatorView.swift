//
//  AppRootCoordinatorView.swift
//  App
//
//  Created by Andrew Elbert on 1/30/25.
//

import FlowStacks
import Foundation
import SwiftUI

struct AppRootCoordinatorView: View {

    @StateObject private var coordinator = AppRootCoordinator()

    var body: some View {
        Router($coordinator.routes) { screen, _ in
            switch screen {
            case .root:
                InitialUI.initialLoad(
                    coordinator: coordinator
                )
            case .home:
                HomeRootCoordinatorView(
                    coordinator: HomeRootCoordinator()
                )
            }
        }
    }
}
