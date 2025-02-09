//
//  AboutFlowCoordinator.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/8/25.
//

import FlowStacks
import Foundation

class AboutFlowCoordinator: FlowCoordinator {

    enum Screen {
        case root
        case team
        case classes
        case partners
    }

    @Published var routes: Routes<Screen>

    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }

    func about_viewPartners() {
        routes.presentSheet(
            .partners
        )
    }

    func about_viewTeam() {
        routes.presentSheet(
            .team
        )
    }

    func about_viewClasses() {
        routes.presentSheet(
            .classes
        )
    }
}
