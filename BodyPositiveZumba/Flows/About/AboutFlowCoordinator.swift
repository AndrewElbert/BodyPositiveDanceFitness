//
//  AboutFlowCoordinator.swift
//  Flows
//
//  Created by Andrew Elbert on 2/8/25.
//

import FlowStacks
import Foundation

class AboutFlowCoordinator: FlowCoordinator {

    enum Screen {
        case root
        case who
        case what
        case team
        case classes
        case partners
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

extension AboutFlowCoordinator: AboutCoordinator {

    func about_viewWho() {
        routes.presentSheet(
            .who
        )
    }

    func about_viewWhat() {
        routes.presentSheet(
            .what
        )
    }

    func about_viewPartners() {
        routes.presentSheet(
            .partners
        )
    }

    func about_viewTeam() {
        routes.presentCover(
            .team
        )
    }

    func about_viewClasses() {
        routes.presentCover(
            .classes
        )
    }
}
