//
//  AboutFlowCoordinatorView.swift
//  Flows
//
//  Created by Andrew Elbert on 2/8/25.
//

import FlowStacks
import Foundation
import SwiftUI

struct AboutFlowCoordinatorView: View {

    @ObservedObject var coordinator: AboutFlowCoordinator

    var body: some View {
        Router($coordinator.routes) { screen, _ in
            switch screen {
            case .root:
                AboutUI.aboutPage(
                    aboutCoordinator: coordinator
                )
            case .team:
                AboutUI.teamPage()
            case .classes:
                ClassesFlowCoordinatorView(
                    coordinator: ClassesFlowCoordinator()
                )
            case .partners:
                AboutUI.partnersPage()
            case .who:
                AboutUI.whoPage()
            case .what:
                AboutUI.whatPage()
            }
        }
    }
}
