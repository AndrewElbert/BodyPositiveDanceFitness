//
//  SideDrawerFlowCoordinator.swift
//  RootCoordinators
//
//  Created by Andrew Elbert on 1/29/25.
//

import FlowStacks
import Foundation

class SideDrawerFlowCoordinator: FlowCoordinator {

    enum Screen {
        case root
        case joinNow
        case classes
        case faq
        case about
        case massage
        case spaceRental
        case contact
    }

    @Published var routes: Routes<Screen>

    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }

    func sideDrawer_dismissLastPresented() {
        routes.dismiss()
    }

    func sideDrawer_viewJoinNow() {
        routes.push(
            .joinNow
        )
    }

    func sideDrawer_viewClasses() {
        routes.push(
            .classes
        )
    }

    func sideDrawer_viewFaq() {
        routes.push(
            .faq
        )
    }

    func sideDrawer_viewAbout() {
        routes.push(
            .about
        )
    }

    func sideDrawer_viewMassage() {
        routes.push(
            .massage
        )
    }

    func sideDrawer_viewspaceRental() {
        routes.push(
            .spaceRental
        )
    }

    func sideDrawer_viewContact() {
        routes.push(
            .contact
        )
    }
}
