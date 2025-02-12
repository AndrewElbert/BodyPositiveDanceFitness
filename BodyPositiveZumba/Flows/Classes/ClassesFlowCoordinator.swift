//
//  ClassesFlowCoordinator.swift
//  Flows
//
//  Created by Andrew Elbert on 2/12/25.
//

import FlowStacks
import Foundation

class ClassesFlowCoordinator: FlowCoordinator {

    enum Screen {
        case root
        case viewAll
    }

    @Published var routes: Routes<Screen>

    init() {
        self.routes = [.root(.root, embedInNavigationView: true)]
    }

}

extension ClassesFlowCoordinator: ClassesCoordinator {
    
    func classes_viewAll() {
        routes.presentCover(
            .viewAll
        )
    }
}
