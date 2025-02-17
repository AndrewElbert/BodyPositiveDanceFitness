//
//  ContactViewModel.swift
//  Contact
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

@MainActor
final class ContactViewModel: ObservableObject {

    @Published var viewState: ContactViewState

    init(
        viewState: ContactViewState = ContactViewState()
    ) {
        self.viewState = viewState
    }

    func handleAction(_ action: String, title: String) {
        guard let url = URL(string: action) else { return }

        if url.scheme == "tel" || url.scheme == "mailto" {
            UIApplication.shared.open(url)
        } else {
            viewState.webViewURL = WebViewURL(title: title, url: url)
        }
    }
}
