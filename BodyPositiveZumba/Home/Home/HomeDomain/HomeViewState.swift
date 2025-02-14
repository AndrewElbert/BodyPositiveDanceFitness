//
//  HomeViewState.swift
//  HomeDomain
//
//  Created by Andrew Elbert on 1/27/25.
//

import SwiftUI

struct HomeViewState {
    
    var showBookClassWebView: Bool = false
    var showJoinWebView: Bool = false
    var currentGreeting: String = ""
    
    var sideDrawerViewState: SideDrawerViewState = SideDrawerViewState()
}
