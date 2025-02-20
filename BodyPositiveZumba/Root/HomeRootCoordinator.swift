//
//  HomeRootCoordinator.swift
//  Root
//
//  Created by Andrew Elbert on 2/8/25.
//

import FlowStacks
import SwiftUI

class HomeRootCoordinator: RootCoordinator {

    enum Screen {
        case root
        case classes
        case about
        case faq
        case massage
        case spaceRental
        case contact
    }

    @Published var routes: Routes<Screen>

    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }

    func popToRoot() {
        routes.popToRoot()
    }

    func dismissLastPresented() {
        routes.dismiss()
    }

}

extension HomeRootCoordinator: HomeCoordinator {

    func home_viewAbout() {
        self.routes.presentCover(
            .about
        )
    }

    func home_viewClasses() {
        routes.presentCover(.classes)
    }
}

extension HomeRootCoordinator: SideDrawerCoordinator {

    func sideDrawer_viewClasses() {
        routes.presentCover(
            .classes
        )
    }

    func sideDrawer_viewFaq() {
        routes.presentCover(
            .faq
        )
    }

    func sideDrawer_viewAbout() {
        routes.presentCover(
            .about
        )
    }

    func sideDrawer_viewMassage() {
        routes.presentCover(
            .massage
        )
    }

    func sideDrawer_viewSpaceRental() {
        routes.presentCover(
            .spaceRental
        )
    }

    func sideDrawer_viewContact() {
        routes.presentSheet(
            .contact
        )
    }
}
