//
//  SideDrawerFlowCoordinatorView.swift
//  RootCoordinators
//
//  Created by Andrew Elbert on 1/29/25.
//

import FlowStacks
import Foundation
import SwiftUI

struct SideDrawerFlowCoordinatorView: View {

    @ObservedObject var coordinator: SideDrawerFlowCoordinator

    var body: some View {
        Router($coordinator.routes) { screen, _ in
            switch screen {
            case .joinNow:
                Text("Join Now")
            case .classes:
                ClassesUI.classesPage()
            case .faq:
                FaqUI.faqPage()
            case .about:
                AboutFlowCoordinatorView(coordinator: AboutFlowCoordinator())
            case .massage:
                MassageUI.massagePage()
            case .spaceRental:
                SpaceRentalUI.spaceRentalPage()
            case .contact:
                ContactUI.contactPage()
            case .root:
                Text("root")
            }
        }
    }
}
