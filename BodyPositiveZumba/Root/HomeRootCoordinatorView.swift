//
//  HomeRootCoordinatorView.swift
//  Root
//
//  Created by Andrew Elbert on 2/8/25.
//

import FlowStacks
import Foundation
import SwiftUI

struct HomeRootCoordinatorView: View {

    @ObservedObject var coordinator: HomeRootCoordinator

    var body: some View {
        Router($coordinator.routes) {
            screen,
            _ in
            switch screen {
            case .classes:
                ClassesFlowCoordinatorView(
                    coordinator: ClassesFlowCoordinator()
                )
            case .faq:
                FaqUI.faqPage()
            case .about:
                AboutFlowCoordinatorView(
                    coordinator: AboutFlowCoordinator()
                )
            case .massage:
                MassageUI.massagePage()
            case .spaceRental:
                SpaceRentalUI.spaceRentalPage()
            case .contact:
                ContactUI.contactPage()
            case .root:
                InitialUI.initialHome(
                    homeCoordinator: coordinator,
                    sideDrawerCoordinator: coordinator
                )
            }
        }
    }
}
