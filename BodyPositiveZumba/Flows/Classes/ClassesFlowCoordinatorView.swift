//
//  ClassesFlowCoordinatorView.swift
//  Flows
//
//  Created by Andrew Elbert on 2/12/25.
//

import FlowStacks
import Foundation
import SwiftUI

struct ClassesFlowCoordinatorView: View {

    @ObservedObject var coordinator: ClassesFlowCoordinator

    var body: some View {
        Router($coordinator.routes) { screen, _ in
            switch screen {
            case .root:
                ClassesUI.classesPage(
                    classesCoordinator: coordinator
                )
            case .viewAll:
                ClassesUI.viewAllClassesPage()
            }
        }
    }
}
