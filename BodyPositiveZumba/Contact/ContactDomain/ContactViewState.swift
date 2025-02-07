//
//  ContactViewState.swift
//  ContactDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct ContactViewState {
    
    struct ContactRowData {
        let title: String
        let icon: String
        let text: String
        let action: String
    }
    
    var webViewURL: WebViewURL?
    let contactRows: [ContactRowData] = [
        ContactRowData(
            title: "Message Us!",
            icon: "message.fill",
            text: "Chat",
            action: "https://www.bodypositivedancefitness.com/contact-1"
        ),
        ContactRowData(
            title: "Call Us!",
            icon: "phone.fill",
            text: "207-536-4617",
            action: "tel://207-536-4617"
        ),
        ContactRowData(
            title: "Email Us!",
            icon: "envelope.fill",
            text: "dancing@bodypositivedancefitness.com",
            action: "mailto:dancing@bodypositivedancefitness.com"
        ),
        ContactRowData(
            title: "Visit Us!",
            icon: "map.fill",
            text: "1100 Brighton Avenue Pine Tree Shopping Center Portland, Maine",
            action: "http://maps.apple.com/?q=123+Main+Street"
        )
    ]
}
