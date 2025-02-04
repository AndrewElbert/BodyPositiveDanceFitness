//
//  MassageViewModel.swift
//  MassageDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

class MassageViewModel: ObservableObject {

    @Published var currentIndex: Int = 0
    @Published var viewState: MassageViewState = MassageViewState()

    func updateBookingURL() {

        let normalizedIndex = viewState.swipableCarouselViewState.currentIndex % viewState.cards.count
        var urlString: String
        var title: String
        if normalizedIndex == 0 {
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
