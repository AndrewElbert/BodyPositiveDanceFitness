//
//  AppRootCoordinator.swift
//  App
//
//  Created by Andrew Elbert on 1/30/25.
//

import FlowStacks
import Foundation

class AppRootCoordinator: RootCoordinator {

    enum Screen {
        case root
        case home
    }

    @Published var routes: Routes<Screen>

    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }
}

extension AppRootCoordinator: InitialLoadCoordinator {
    func initialLoad_viewHome() {
        routes.presentCover(.home)
    }
}
