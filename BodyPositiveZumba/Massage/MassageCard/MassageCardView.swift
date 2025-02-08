//
//  MassageCardView.swift
//  MassageUI
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct MassageCardView: View {

    var card: CardModel
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .clipped()
                .cornerRadius(15)

            Text(card.name)
                .font(.system(size: 24, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 10)

            Text(card.parlor)
                .font(.system(size: 14, design: .serif))
                .foregroundColor(Constants.Colors.darkOrange)

            if isExpanded {
                Text(card.bio)
                    .font(.system(size: 16, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(.opacity)
            } else {
                Text(Constants.Massage.bioTap)
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                isExpanded.toggle()
            }
        }
    }
}
