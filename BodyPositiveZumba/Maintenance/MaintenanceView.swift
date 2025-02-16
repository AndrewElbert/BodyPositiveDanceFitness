//
//  MaintenanceView.swift
//  Maintenance
//
//  Created by Andrew Elbert on 2/15/25.
//

import SwiftUI

struct MaintenanceView: View {

    var body: some View {
        VStack(spacing: 40) {
            Text(Constants.Maintenance.pageTitle)
                .font(.system(size: 56, weight: .bold, design: .rounded))
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
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                    )
                )
                .padding(.top, 40)

            Text(Constants.Maintenance.pageBio)
                .font(.sfProBodyTextMedium(size: 22))
                .italic()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 30) {
                Text(Constants.Maintenance.blockTitle)
                    .font(.sfProDisplayBold(size: 22))
                    .foregroundColor(Constants.Colors.darkerCyan)

                VStack(spacing: 24) {
                    contactRow(
                        title: Constants.Maintenance.visit,
                        detail: Constants.Common.companyAddress
                    )

                    Divider()
                        .background(Color.gray.opacity(0.3))

                    contactRow(
                        title: Constants.Maintenance.call,
                        detail: Constants.Common.companyPhone
                    )

                    Divider()
                        .background(Color.gray.opacity(0.3))

                    contactRow(
                        title: Constants.Maintenance.email,
                        detail: Constants.Common.companyEmail
                    )
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(
                        color: Color.black.opacity(0.1),
                        radius: 15,
                        x: 0,
                        y: 5
                    )
            )
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 40)
        .background(Constants.Colors.neonCyan.opacity(0.03).ignoresSafeArea())
    }

    private func contactRow(
        title: String,
        detail: String
    ) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Text(detail)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
