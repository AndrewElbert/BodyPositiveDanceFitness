//
//  TeamCardView.swift
//  About
//
//  Created by Andrew Elbert on 2/9/25.
//

import SwiftUI

struct TeamCardView: View {

    var card: TeamCardModel

    var body: some View {
        VStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 260, height: 260)
                .clipped()
                .cornerRadius(15)

            Text(card.name)
                .font(.sfProRoundedTextBold(size: 24))
                .foregroundColor(.black)
                .padding(.top, 10)
                .padding(.bottom, 16)

            Text(card.role)
                .font(.sfProBodyTextMedium(size: 20))
                .multilineTextAlignment(.center)
                .foregroundColor(.orange)
                .padding(.horizontal)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
        )
    }
}
