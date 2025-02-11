//
//  FaqView.swift
//  FaqUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct FaqView: View, ActionableView {
    
    enum Action {
        case toggleQuestion(Int)
    }
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Binding private var viewState: FaqViewState
    var onAction: ((Action) -> Void)?
    
    private let titleStyle = Font.sfProDisplayBold(size: 24)
    private let standardSpacing: CGFloat = 18
    
    private var adaptiveTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.9) : Color.black
    }
    
    public init(
        viewState: Binding<FaqViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .topLeading) {
                scrollContent
            }
            .toolbar {
                ToolbarButton.backButton {
                    dismiss()
                }
                ToolbarButton.closeButton {
                    dismiss()
                }
            }
        }
    }
    
    private var scrollContent: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: standardSpacing) {
                pageTitle
                faqItems
            }
            .padding()
        }
    }
    
    private var pageTitle: some View {
        Text(Constants.FAQ.pageTitle)
            .font(titleStyle)
            .foregroundColor(adaptiveTextColor)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private var faqItems: some View {
        ForEach(
            Array(viewState.faqItems.indices),
            id: \.self
        ) { index in
            FaqItemComponent(
                viewModel: FaqItemViewModel(
                    viewState: $viewState.faqItems[index]
                )
            )
            .transition(.opacity)
        }
    }
}
