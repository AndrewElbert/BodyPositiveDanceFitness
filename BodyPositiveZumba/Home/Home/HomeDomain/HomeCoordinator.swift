//
//  HomeCoordinator.swift
//  HomeDomain
//
//  Created by Andrew Elbert on 1/30/25.
//

import Foundation
import SwiftUI

protocol HomeCoordinator: ScreenCoordinator {

    func home_viewAbout()
    func home_viewClasses()
    func home_viewJoinNow()

}
