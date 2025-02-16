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
            .frame(width: 260, height: 260)
            .padding(.top, 20)
    }

    var websiteButton: some View {
        Button(
            action: updateURL
        ) {
            Text(Constants.Partners.buttonText)
                .font(.sfProRoundedTextSemibold(size: 20))
                .foregroundColor(.orange)
                .frame(width: 222, height: 44)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.orange, lineWidth: 2)
                )
        }
        .padding(.top, 35)
        .padding(.bottom, 15)
    }

    private func updateURL() {
        viewState.displayURL = partner.url
    }
}
