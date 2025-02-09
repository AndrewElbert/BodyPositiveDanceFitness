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
        case sidedrawer
        case joinNow
        case classes
        case about
    }

    @Published var routes: Routes<Screen>

    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }
}

extension HomeRootCoordinator: HomeCoordinator {
    
    func home_viewAbout() {
        self.routes.presentCover(
            .about,
            embedInNavigationView: true
        )
    }
    
    func home_viewSideDrawer() {
        self.routes.presentCover(
            .sidedrawer,
            embedInNavigationView: true
        )
    }
    
    func home_viewClasses() {
        routes.presentSheet(.classes)
    }
    
    func home_viewJoinNow() {
        routes.presentSheet(.joinNow)
    }
}


