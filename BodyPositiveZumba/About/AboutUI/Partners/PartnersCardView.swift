//
//  PartnersCardView.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

struct PartnersCard: View {

    var partner: Partner
    @Binding var viewState: PartnersViewState

    var body: some View {
        VStack {
            logoImage
            websiteButton
        }
        .frame(width: 275, height: 450)
    }
}

private extension PartnersCard {

    var logoImage: some View {
        Image(partner.image)
            .resizable()
            .scaledToFit()
            .frame(width: 240, height: 240)
            .padding(.top, 20)
            .shadow(
                color: .orange.opacity(0.5),
                radius: 10
            )
    }

    var websiteButton: some View {
        
        Button(
            action: updateURL
        ) {
            Text(Constants.Partners.buttonText)
                .font(.system(size: 22))
                .foregroundColor(.orange)
                .underline()
                .padding(.horizontal, 8)
        }
        .cornerRadius(20)
        .padding(.top, 40)
        .padding(.bottom, 15)
    }

    private func updateURL() {
        viewState.displayURL = partner.url
    }
}
