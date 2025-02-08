//
//  ExpandableParagraphModel.swift
//  AboutDomain
//
//  Created by Andrew Elbert on 2/8/25.
//

import Foundation

struct ExpandableParagraphModel: Equatable, Identifiable {

    let id = UUID()
    let title: String
    let content: String
    var isExpanded: Bool
}
