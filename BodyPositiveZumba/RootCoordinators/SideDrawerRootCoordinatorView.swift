//
//  SideDrawerRootCoordinatorView.swift
//  RootCoordinators
//
//  Created by Andrew Elbert on 1/29/25.
//

import FlowStacks
import Foundation
import SwiftUI

struct SideDrawerRootCoordinatorView: View {

    @ObservedObject var coordinator: SideDrawerRootCoordinator

    var body: some View {
        Router($coordinator.routes) { screen, _ in
            switch screen {
            case .root:
                Text("Root Screen")
            case .joinNow:
                Text("Join Now Screen")
            case .classes:
                Text("Classes Screen")
            case .newcomers:
                Text("text")
            case .about:
                Text("About Screen")
            case .contact:
                Text("Contact Screen")
            case .signIn:
                Text("Sign In Screen")
            case .subscription:
                Text("Subscription Screen")
            }
        }
    }
}
