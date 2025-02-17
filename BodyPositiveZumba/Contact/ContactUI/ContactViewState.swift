//
//  ContactViewState.swift
//  Contact
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct ContactViewState {

    var webViewURL: WebViewURL?
    let contactRows: [ContactRowData] = Constants.Contact.contactRows
    var animateGradient = false
    var selectedRow: String?

}
