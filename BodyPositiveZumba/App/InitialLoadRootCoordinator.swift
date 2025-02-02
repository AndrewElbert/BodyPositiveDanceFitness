//
//  InitialLoadRootCoordinator.swift
//  App
//
//  Created by Andrew Elbert on 1/30/25.
//

import FlowStacks
import Foundation

class InitialLoadRootCoordinator: RootCoordinator {

    enum Screen {
        case root
        case home
        case joinNow
        case classes
        case faq
        case about
        case massage
        case spaceRental
        case subscription
    }

    @Published var routes: Routes<Screen>

    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }
}

extension InitialLoadRootCoordinator: InitialLoadCoordinator {
    func initialLoad_viewHome() {
        routes.presentCover(.home)
    }
}

extension InitialLoadRootCoordinator: HomeCoordinator {

}

extension InitialLoadRootCoordinator: SideDrawerCoordinator {

    func sideDrawer_viewspaceRental() {
        routes.presentSheet(
            .spaceRental
        )
    }

    func sideDrawer_dismissLastPresented() {
        routes.dismiss()
    }

    func sideDrawer_viewJoinNow() {
        routes.presentSheet(
            .joinNow
        )
    }

    func sideDrawer_viewClasses() {
        routes.presentSheet(
            .classes
        )
    }

    func sideDrawer_viewFaq() {
        routes.presentSheet(
            .faq
        )
    }

    func sideDrawer_viewAbout() {
        routes.presentSheet(
            .about
        )
    }

    func sideDrawer_viewMassage() {
        routes.presentSheet(
            .massage
        )
    }

    func sideDrawer_viewSubscription() {
        routes.presentSheet(
            .subscription
        )
    }
}
