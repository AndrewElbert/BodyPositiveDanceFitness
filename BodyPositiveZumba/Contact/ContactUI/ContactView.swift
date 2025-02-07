//
//  ContactView.swift
//  Contact
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactView: View {
    @StateObject private var viewModel = ContactViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                CloseButton(
                    dismiss: {
                        dismiss()
                    }
                )
            }
            
            VStack(spacing: 60) {
                ForEach(viewModel.state.contactRows, id: \.title) { rowData in
                    ContactRow(
                        data: rowData,
                        onAction: { viewModel.handleAction(rowData.action, title: rowData.title) }
                    )
                }
            }
            .padding()
            .frame(width: 333, height: 667)
            .background(
                RadialGradient(
                    gradient: Gradient(
                        colors: [
                            Constants.Colors.neonCyan.opacity(0.03),
                            Constants.Colors.neonCyan.opacity(0.10)
                        ]
                    ),
                    center: .center,
                    startRadius: 100,
                    endRadius: 300
                )
            )
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.orange, lineWidth: 3))
            .shadow(radius: 10)
            .padding()
        }
        .sheet(item: $viewModel.state.webViewURL) { webView in
            WebViewContainer(url: webView.url, title: webView.title)
        }
        Spacer()
    }
}

struct ContactRow: View {
    let data: ContactViewState.ContactRowData
    let onAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                Text(data.title)
                    .font(.system(size: 33, design: .serif))
                    .padding(.bottom, 11)
                Image(systemName: data.icon)
                    .foregroundColor(.orange)
                    .font(.system(size: 29))
                    .padding(.leading, 8)
                    .padding(.bottom, 11)
            }
            Button(action: onAction) {
                Text(data.text)
                    .font(.system(size: 22, design: .serif))
                    .foregroundColor(.blue)
                    .underline()
            }
        }
        .multilineTextAlignment(.center)
    }
}
