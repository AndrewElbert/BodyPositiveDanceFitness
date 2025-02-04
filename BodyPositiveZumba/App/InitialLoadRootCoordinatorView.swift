//
//  InitialLoadRootCoordinatorView.swift
//  App
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
                InitialUI.initialLoad(coordinator: coordinator)
            case .home:
                InitialUI.initialHome(
                    homeCoordinator: coordinator,
                    sideDrawerCoordinator: coordinator
                )
            case .joinNow:
                Text("Join Now")
            case .classes:
                Text("Classes")
            case .faq:
                FaqUI.faqPage()
            case .about:
                Text("About")
            case .massage:
                MassageUI.massagePage()
            case .spaceRental:
                SpaceRentalUI.spaceRentalPage()
            case .contact:
                Text("Contact")
            }
        }
    }
}
