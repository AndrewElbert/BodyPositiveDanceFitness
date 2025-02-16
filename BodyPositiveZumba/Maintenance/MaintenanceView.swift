//
//  MaintenanceView.swift
//  Maintenance
//
//  Created by Andrew Elbert on 2/15/25.
//

import SwiftUI

struct MaintenanceView: View {
    
    var body: some View {
        VStack(spacing: 60) {
            Text(Constants.Maintenance.pageTitle)
                .font(
                    .sfProDisplayBold(size: 56)
                )
                .foregroundColor(.primary)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(
                            colors: Constants.Colors.rainbow
                        ),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                        .mask(
                            Text(Constants.Maintenance.pageTitle)
                                .font(
                                    .sfProDisplayBold(size: 56)
                                )
                        )
                )
            
            Text(Constants.Maintenance.pageBio)
                .font(.sfProBodyTextRegular(size: 22))
                .italic()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .lineLimit(nil)
            
            VStack(spacing: 25) {
                Text(Constants.Maintenance.blockTitle)
                    .font(.sfProDisplayMedium(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                infoRow(
                    title: Constants.Maintenance.visit,
                    detail: Constants.Common.companyAddress
                )
                infoRow(
                    title: Constants.Maintenance.call,
                    detail: Constants.Common.companyPhone
                )
                infoRow(
                    title: Constants.Maintenance.email,
                    detail: Constants.Common.companyEmail
                )
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(18)
            .shadow(radius: 15)
            .padding(.top, 30)
        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
    
    private func infoRow(
        title: String,
        detail: String
    ) -> some View {
        VStack {
            Text(title)
                .font(.sfProSerifBold(size: 18))
                .foregroundColor(.black)
            Spacer()
            Text(detail)
                .font(.sfProSerifRegular(size: 10))
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
        }
        .frame(alignment: .center)
        .padding(.vertical, 6)
    }
}



