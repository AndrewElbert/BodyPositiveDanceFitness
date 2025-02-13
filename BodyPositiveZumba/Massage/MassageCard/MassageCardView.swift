//
//  MassageCardView.swift
//  MassageUI
//
//  Created by Andrew Elbert on 1/31/25.
//

import SwiftUI

struct MassageCardView: View {
    
    var card: MassageCardModel
    var isCurrentCard: Bool
    @State var viewState: MassageCardViewState
    
    var body: some View {
        VStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .clipped()
                .cornerRadius(15)

            Text(card.fullName)
                .font(.sfProRoundedTextMedium(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 10)

            Text(card.parlor)
                .font(.sfProBodyTextRegular(size: 16))
                .foregroundColor(Constants.Colors.darkOrange)

            if viewState.isExpanded {
                Text(card.bio)
                    .font(.sfProBodyTextRegular(size: 17))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(.opacity)
            } else {
                Text(Constants.Massage.bioTap)
                    .font(.sfProBodyTextRegular(size: 14))
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
                viewState.isExpanded.toggle()
            }
        }
        .onChange(of: isCurrentCard) { oldvalue, newValue in
            if !newValue {
                withAnimation(.easeOut(duration: 1.4)) {
                    viewState.isExpanded = false
                }
            }
        }
    }
}
