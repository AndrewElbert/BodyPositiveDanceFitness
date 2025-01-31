//
//  SideDrawerCoordinator.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/29/25.
//

import Foundation

protocol SideDrawerCoordinator: ScreenCoordinator {

    func sideDrawer_viewJoinNow()
    func sideDrawer_viewClasses()
    func sideDrawer_viewNewcomers()
    func sideDrawer_viewAbout()
    func sideDrawer_viewContact()
    func sideDrawer_viewSignIn()
    func sideDrawer_viewSubscription()
}
