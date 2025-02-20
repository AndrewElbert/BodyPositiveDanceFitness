//
//  DrawerButtonViewState.swift
//  SideDrawer
//
//  Created by Andrew Elbert on 2/4/25.
//

import SwiftUI

struct DrawerButtonViewState: Identifiable {
    
    let id = UUID()
    let title: String
    let icon: String?
    var type: SideDrawerView.Action
    var isPressed: Bool = false

    init(
        title: String,
        icon: String? = nil,
        type: SideDrawerView.Action,
        isPressed: Bool = false
    ) {
        self.title = title
        self.icon = icon
        self.type = type
        self.isPressed = isPressed
    }
}
