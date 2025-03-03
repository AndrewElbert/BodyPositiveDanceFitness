//
//  Partner.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

enum Partner: String, CaseIterable, Identifiable {

    case overland = "Overland Honey"
    case beam = "Beam Skin Studio"
    case dtx = "Danse Très Xtrême"
    case llh = "Lady Love Holistics"

    var id: String { self.rawValue }

    var url: WebViewURL {
        switch self {
        case .overland:
            return WebViewURL(
                title: "",
                url: URL(string: "https://overlandhoney.com")!
            )
        case .beam:
            return WebViewURL(
                title: "",
                url: URL(string: "https://www.beamskinstudio.com/")!
            )
        case .dtx:
            return WebViewURL(
                title: "",
                url: URL(string: "https://dansetresxtreme.com/")!
            )
        case .llh:
            return WebViewURL(
                title: "",
                url: URL(string: "https://ladyloveholistics.com/")!
            )
        }
    }

    var image: String {
        switch self {
        case .overland:
            return "OverlandLogo"
        case .beam:
            return "BeamSkinLogo"
        case .dtx:
            return "DtxLogo"
        case .llh:
            return "LadyLoveHolisticsLogo"
        }
    }

    var name: String {
        return self.rawValue
    }

    var description: String? {
        switch self {
        case .overland:
            return "Local honey producers with sustainable practices."
        case .beam:
            return "Premium skincare and beauty treatments."
        case .dtx:
            return "Dance studio specializing in extreme and dynamic styles."
        case .llh:
            return "Natural holistic wellness and healing products."
        }
    }
}
