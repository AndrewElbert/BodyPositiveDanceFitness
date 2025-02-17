//
//  AboutMainSections.swift
//  About
//
//  Created by Andrew Elbert on 2/8/25.
//

import Foundation

struct AboutMainSectionModel: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let identifier: String

    static let defaultSections: [AboutMainSectionModel] = [
        .init(title: "Meet Our Team!", identifier: "team"),
        .init(title: "View Our Classes", identifier: "classes"),
        .init(title: "Partners", identifier: "partners"),
        .init(title: "Media", identifier: "media")
    ]
}
