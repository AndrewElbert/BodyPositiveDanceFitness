//
//  AboutViewState.swift
//  AboutDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct AboutViewState: Equatable {
    
    let sections: [AboutMainSectionModel]

    static let `default` = AboutViewState(
        sections: AboutMainSectionModel.defaultSections
    )

    var mediaUrl: WebViewURL?
}
