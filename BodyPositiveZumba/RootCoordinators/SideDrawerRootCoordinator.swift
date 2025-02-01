//
//  SideDrawerRootCoordinator.swift
//  RootCoordinators
//
//  Created by Andrew Elbert on 1/29/25.
//

import FlowStacks
import Foundation

class SideDrawerRootCoordinator: RootCoordinator {

    enum Screen {
        case root
        case joinNow
        case classes
        case faq
        case about
        case massage
        case signIn
        case subscription
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

    func sideDrawer_viewSignin() {
        routes.push(
            .signIn
        )
    }

    func sideDrawer_viewSubscription() {
        routes.push(
            .subscription
        )
    }
}
