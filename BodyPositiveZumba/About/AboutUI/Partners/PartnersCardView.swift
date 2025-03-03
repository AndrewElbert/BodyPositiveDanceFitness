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
    var isCurrentCard: Bool
    @State private var showBorder: Bool = false

    var body: some View {

        ZStack {
            cardBackground
            cardBorder

            VStack(spacing: 0) {
                partnerImage
                partnerName
                divider
                partnerDescription
                Spacer()
                actionButton
            }
        }
        .padding()
        .frame(width: 315, height: 500)
        .onChange(of: isCurrentCard) { _, newValue in
            if newValue {
                withAnimation(.easeIn(duration: 0.3)) {
                    showBorder = true
                }
            } else {
                withAnimation(.easeOut(duration: 0.2)) {
                    showBorder = false
                }
            }
        }
        .onAppear {
            showBorder = isCurrentCard
        }
    }

    private var cardBackground: some View {

        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .shadow(
                color: isCurrentCard ? Constants.Colors.neonCyan.opacity(0.3) : Color.gray.opacity(0.2),
                radius: 10,
                x: 0,
                y: 5
            )
    }

    private var cardBorder: some View {

        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(
                LinearGradient(
                    colors: Constants.Colors.logoColorGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 4.5
            )
            .opacity(showBorder ? 1 : 0)
    }

    private var partnerImage: some View {

        Image(partner.image)
            .resizable()
            .scaledToFit()
            .frame(width: 220, height: 220)
            .padding(.top, 30)
            .padding(.bottom, 20)
    }

    private var partnerName: some View {

        Text(partner.name)
            .font(.sfProDisplayBold(size: 20))
            .foregroundColor(.black)
            .padding(.bottom, 10)
    }

    private var divider: some View {

        Rectangle()
            .fill(
                LinearGradient(
                    colors: Constants.Colors.logoColorGradient,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: 200, height: 1)
            .padding(.bottom, 12)
    }

    private var partnerDescription: some View {

        Group {
            if let description = partner.description {
                Text(description)
                    .font(.sfProBodyTextRegular(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
        }
    }

    private var actionButton: some View {

        Button(action: {
            viewState.displayURL = partner.url
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }) {
            HStack(spacing: 10) {
                Image(systemName: "globe")
                    .font(.system(size: 18, weight: .semibold))

                Text(Constants.Partners.buttonText)
                    .font(.system(size: 18, weight: .semibold))

                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundColor(.black)
            .frame(width: 240, height: 50)
            .background(
                LinearGradient(
                    colors: Constants.Colors.logoColorGradientLight,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(22)
            .shadow(
                color: .gray.opacity(0.5),
                radius: 5,
                x: 0,
                y: 3
            )
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.bottom, 30)
    }
}
