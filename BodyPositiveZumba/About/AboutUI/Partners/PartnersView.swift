//
//  PartnersView.swift
//  About
//
//  Created by Andrew Elbert on 2/10/25.
//

import SwiftUI

struct PartnersView: View {

    @Binding var viewState: PartnersViewState

    var body: some View {

        VStack {
            Text(Constants.Partners.pageTitle)
                .font(.sfProDisplayBold(size: 40))
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.bottom, 55)

            SwipableCarouselComponent<AnyView, Partner>(
                viewModel: SwipableCarouselViewModel(viewState: $viewState.carouselViewState)
            ) { partner, isCurrentCard in
                AnyView(
                    PartnersCard(partner: partner, viewState: $viewState)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isCurrentCard ? Color.orange : Color.clear, lineWidth: isCurrentCard ? 3 : 0)
                        )
                )
            }
            .frame(height: 375)
        }
        .sheet(item: $viewState.displayURL) { currentCard in
            WebViewContainer(url: currentCard.url, title: currentCard.title)
        }
        Spacer()
    }
}
