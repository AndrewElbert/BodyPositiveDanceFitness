//
//  ExpandableSectionViewState.swift
//  SpaceRental
//
//  Created by Andrew Elbert on 2/2/25.
//

import SwiftUI

struct ExpandableSectionViewState {
    var animatedBulletPointViewStates: [AnimatedBulletPointViewState]
    var title: String
    var items: [(String, String)]
    var isExpanded: Bool

    init(
        title: String,
        items: [(String, String)],
        isExpanded: Bool = false
    ) {
        self.title = title
        self.items = items
        self.isExpanded = isExpanded
        self.animatedBulletPointViewStates = items.map { item in
            AnimatedBulletPointViewState(text: item.0, emoji: item.1)
        }
    }
}
