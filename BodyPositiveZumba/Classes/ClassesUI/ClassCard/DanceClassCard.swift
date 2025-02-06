//
//  DanceClassCard.swift
//  ClassesUI
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct DanceClassCard: View {

    var danceClass: DanceClass

    var body: some View {
        VStack {
            Text(danceClass.rawValue)
                .font(.system(size: 30, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 10)

            Button(action: {
                if let url = URL(string: "https://www.bodypositivedancefitness.com/join-now-1") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Join Now!")
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                    .foregroundColor(.black)
                    .frame(width: 222, height: 44)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
            .padding(.top, 35)
            .padding(.bottom, 15)
        }
        .frame(width: 250, height: 350)
        .background(
            RadialGradient(
                gradient: Gradient(colors: [
                    danceClass.color.opacity(0.01),
                    danceClass.color.opacity(0.1)
                ]),
                center: .center, startRadius: 77, endRadius: 111
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(danceClass.color, lineWidth: 2)
        )
        .cornerRadius(15)
        .shadow(color: danceClass.color.opacity(0.8), radius: 30, x: 0, y: 0)
        .shadow(color: danceClass.color.opacity(0.4), radius: 40, x: 0, y: 0)
    }
}
