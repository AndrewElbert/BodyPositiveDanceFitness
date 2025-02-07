//
//  ContactViewModel.swift
//  ContactDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

final class ContactViewModel: ObservableObject {
    
    @Published var state: ContactViewState
    
    init(state: ContactViewState = ContactViewState()) {
        self.state = state
    }
    
    func handleAction(_ action: String, title: String) {
        guard let url = URL(string: action) else { return }
        
        if url.scheme == "tel" || url.scheme == "mailto" {
            UIApplication.shared.open(url)
        } else {
            state.webViewURL = WebViewURL(title: title, url: url)
        }
    }
    
    func dismissWebView() {
        state.webViewURL = nil
    }
}
