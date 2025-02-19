//
//  ContactView.swift
//  Contact
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactView: View, ActionableView {
    
    enum Action {
        case handleAction(
            action: String,
            title: String
        )
    }

    @Binding var viewState: ContactViewState
    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView.padding(.bottom, 20)
                contactRowsSection
                Spacer()
            }
            .sheet(item: $viewState.webViewURL) { webView in
                WebViewContainer(url: webView.url, title: webView.title)
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarButton.backButton { dismiss() }
                ToolbarButton.closeButton { dismiss() }
            }
        }
    }

    private var headerView: some View {
        let titleText = Constants.Contact.pageTitle
        return VStack(spacing: 15) {
            Text(titleText)
                .font(.sfProSerifBold(size: 35))
                .italic()
                .foregroundColor(.clear)
                .multilineTextAlignment(.center)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: Constants.Colors.rainbow),
                        startPoint: viewState.animateGradient ? .leading : .trailing,
                        endPoint: viewState.animateGradient ? .trailing : .leading
                    )
                    .mask(
                        Text(titleText)
                            .font(.sfProSerifBold(size: 33))
                            .italic()
                            .multilineTextAlignment(.center)
                    )
                )
                .onAppear {
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                        viewState.animateGradient.toggle()
                    }
                }

            Text(Constants.Contact.pageBio)
                .font(.sfProRoundedTextRegular(size: 18))
                .foregroundColor(.gray)
        }
        .padding(.top, 25)
    }

    private var contactRowsSection: some View {
        VStack(spacing: 0) {
            rowDivider

            ForEach(viewState.contactRows, id: \.title) { row in
                ContactRowContainer(
                    data: row,
                    isSelected: viewState.selectedRow == row.title,
                    onSelect: {
                        withAnimation(.spring()) {
                            viewState.selectedRow = row.title
                        }
                    },
                    onAction: {
                        onAction?(.handleAction(
                            action: row.action,
                            title: row.title)
                        )
                    }
                )

                if row != viewState.contactRows.last { rowDivider }
            }

            rowDivider
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }

    private var rowDivider: some View {
        Divider()
            .background(Color.gray)
            .padding(.horizontal)
    }
}

struct ContactRowContainer: View {
    let data: ContactRowData
    let isSelected: Bool
    let onSelect: () -> Void
    let onAction: () -> Void

    var body: some View {
        VStack {
            ContactRow(data: data, onAction: onAction)
                .padding(.vertical, 15)
                .contentShape(Rectangle())
                .onTapGesture(perform: onSelect)
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(), value: isSelected)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(isSelected ? 0.1 : 0))
                .animation(.easeInOut, value: isSelected)
        )
    }
}

struct ContactRow: View {
    let data: ContactRowData
    let onAction: () -> Void
    @State private var iconRotation: Double = 0

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: data.icon)
                .foregroundColor(data.iconColor)
                .font(.system(size: 33))
                .rotationEffect(.degrees(iconRotation))
                .onAppear {
                    withAnimation(
                        .spring(response: 0.5, dampingFraction: 0.5)
                        .repeatCount(1)
                    ) {
                        iconRotation = 360
                    }
                }

            Button(action: onAction) {
                Text(data.text)
                    .font(.sfProRoundedTextRegular(size: 16))
                    .foregroundColor(.blue)
                    .underline()
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .multilineTextAlignment(.center)
    }
}
