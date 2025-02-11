//
//  AboutViewState.swift
//  AboutDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct AboutViewState: Equatable {

    var expandableContents: [ExpandableParagraphModel]
    let sections: [AboutMainSectionModel]

    static let `default` = AboutViewState(
        expandableContents: [
            .init(
                title: Constants.About.button1Title,
                content: Constants.About.button1Content,
                isExpanded: false
            ),
            .init(
                title: Constants.About.button2Title,
                content: Constants.About.button2Content,
                isExpanded: false
            )
        ],
        sections: AboutMainSectionModel.defaultSections
    )

    var mediaUrl: WebViewURL?
}
