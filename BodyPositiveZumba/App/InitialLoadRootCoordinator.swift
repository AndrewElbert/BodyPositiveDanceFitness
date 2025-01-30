//
//  InitialLoadRootCoordinator.swift
//  Coordinator
//
//  Created by Andrew Elbert on 1/30/25.
//

import FlowStacks
import Foundation

class InitialLoadRootCoordinator: RootCoordinator {
    
    enum Screen {
        case root
        case home
    }
    
    @Published var routes: Routes<Screen>
    
    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }
    
    func initialLoad_viewHome(){
        routes.push(
            .home
        )
    }
}
