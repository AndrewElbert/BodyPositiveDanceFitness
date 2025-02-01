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
        
        let normalizedIndex = viewState.currentIndex % viewState.cards.count
        var urlString: String
        if normalizedIndex == 0 {
            urlString = Constants.Massage.ladyLoveHolisticURL
        } else {
            urlString = Constants.Massage.swannsHealingElementsURL
        }
        
        if let url = URL(string: urlString) {
            viewState.bookingURL = WebViewURL(url: url)
        }
    }
}

