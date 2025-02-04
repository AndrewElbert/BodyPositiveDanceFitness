//
//  SideDrawerCoordinator.swift
//  SideDrawerDomain
//
//  Created by Andrew Elbert on 1/29/25.
//

import Foundation

protocol SideDrawerCoordinator: ScreenCoordinator {

    func sideDrawer_viewJoinNow()
    func sideDrawer_viewClasses()
    func sideDrawer_viewFaq()
    func sideDrawer_viewAbout()
    func sideDrawer_viewMassage()
    func sideDrawer_viewSpaceRental()
    func sideDrawer_viewContact()
}
