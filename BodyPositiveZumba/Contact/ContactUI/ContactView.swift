//
//  ContactView.swift
//  Contact
//
//  Created by Andrew Elbert on 2/6/25.
//

import SwiftUI

struct ContactView: View, ActionableView {
    enum Action {
        case handleAction(action: String, title: String)
    }

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) private var dismiss
    @Binding var viewState: ContactViewState
    @State private var animateGradient = false
    @State private var selectedRow: String? = nil

    public init(
        viewState: Binding<ContactViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                    .padding(.bottom, 20)
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
        VStack(spacing: 15) {
            Text("Please Reach Out\nAnytime!")
                .font(.sfProSerifBold(size: 35))
                .italic()
                .foregroundColor(.clear)
                .multilineTextAlignment(.center)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: Constants.Colors.rainbow),
                        startPoint: animateGradient ? .leading : .trailing,
                        endPoint: animateGradient ? .trailing : .leading
                    )
                    .mask(
                        Text("Please Reach Out\nAnytime!")
                            .font(.sfProSerifBold(size: 33))
                            .italic()
                            .multilineTextAlignment(.center)
                    )
                )
                .onAppear {
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            
            Text("We're here to help and listen")
                .font(.sfProRoundedTextRegular(size: 16))
                .foregroundColor(.secondary)
        }
        .padding(.top, 25)
    }
    
    private var contactRowsSection: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.gray)
                .padding(.horizontal)
            
            ForEach(viewState.contactRows, id: \.title) { row in
                ContactRowContainer(
                    data: row,
                    isSelected: selectedRow == row.title,
                    onSelect: {
                        withAnimation(.spring()) {
                            selectedRow = row.title
                        }
                    },
                    onAction: {
                        onAction?(.handleAction(action: row.action, title: row.title))
                    }
                )
                
                if row != viewState.contactRows.last {
                    Divider()
                        .background(Color.gray)
                        .padding(.horizontal)
                }
            }
            Divider()
                .background(Color.gray)
                .padding(.horizontal)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
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
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .multilineTextAlignment(.center)
    }
}
