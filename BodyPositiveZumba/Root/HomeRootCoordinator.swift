//
//  HomeRootCoordinator.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/8/25.
//

import FlowStacks
import SwiftUI

class HomeRootCoordinator: RootCoordinator {

    enum Screen {
        case root
        case joinNow
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
}

extension HomeRootCoordinator: HomeCoordinator {

    func home_viewAbout() {
        self.routes.push(
            .about
        )
    }

    func home_viewClasses() {
        routes.presentSheet(.classes)
    }

    func home_viewJoinNow() {
        routes.presentSheet(.joinNow)
    }
}

extension HomeRootCoordinator: SideDrawerCoordinator {

    func sideDrawer_popToRoot() {
        routes.popToRoot()
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
