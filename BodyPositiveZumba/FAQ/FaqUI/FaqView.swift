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
    @Binding private var viewState: FaqViewState
    var onAction: ((Action) -> Void)?

    private let titleStyle = Font.system(size: 24, weight: .bold, design: .serif)
    private let standardSpacing: CGFloat = 16
    private let titlePadding = EdgeInsets(
        top: 24,
        leading: 0,
        bottom: 20,
        trailing: 0
    )

    public init(
        viewState: Binding<FaqViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            scrollContent
            closeButton
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
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(titlePadding)
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

    private var closeButton: some View {
        CloseButton {
            dismiss()
        }
    }
}
