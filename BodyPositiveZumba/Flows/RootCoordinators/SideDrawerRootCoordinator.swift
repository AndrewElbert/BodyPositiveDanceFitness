//
//  SideDrawerRootCoordinator.swift
//  BodyPositiveZumba
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
        case newcomers
        case about
        case contact
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
    
    func sideDrawer_viewNewcomers() {
        routes.push(
            .newcomers
        )
    }
    
    func sideDrawer_viewAbout() {
        routes.push(
            .about
        )
    }
    
    func sideDrawer_viewContact() {
        routes.push(
            .contact
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
