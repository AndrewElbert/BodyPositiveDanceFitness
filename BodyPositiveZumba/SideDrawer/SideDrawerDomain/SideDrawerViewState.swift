//
//  SideDrawerViewState.swift
//  SideDrawerDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct SideDrawerViewState {
    var isMenuOpen: Bool = false
    var showDimBackground: Bool = false
    var dragOffset = CGSize.zero
}
