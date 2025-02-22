//
//  MassageViewModel.swift
//  Massage
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

@MainActor
class MassageViewModel: ObservableObject {

    @Published var viewState: MassageViewState = MassageViewState()

    func updateBookingURL() {

        var urlString: String
        var title: String
        if viewState.normalizedIndex == 0 {
            urlString = Constants.Massage.ladyLoveHolisticURL
            title = Constants.Massage.LindseyHerseyParlor
        } else {
            title = Constants.Massage.ShelbySwannParlor
            urlString = Constants.Massage.swannsHealingElementsURL
        }

        if let url = URL(string: urlString) {
            viewState.bookingURL = WebViewURL(
                title: title,
                url: url
            )
        }
    }
}
