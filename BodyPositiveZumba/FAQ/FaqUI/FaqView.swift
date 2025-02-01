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

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) var dismiss
    @Binding var viewState: FaqViewState

    public init(
        viewState: Binding<FaqViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(Constants.FAQ.pageTitle)
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 24)
                        .padding(.bottom, 20)

                    ForEach(viewState.faqItems.indices, id: \.self) { index in
                        FaqItem(
                            question: viewState.faqItems[index].question,
                            answer: viewState.faqItems[index].answer,
                            isExpanded: viewState.expandedQuestions.contains(index),
                            isClosing: viewState.closingIndex == index,
                            toggleExpanded: {
                                onAction?(.toggleQuestion(index))
                            }
                        )
                    }
                }
                .padding()
            }
            CloseButton(dismiss: {
                dismiss()
            })
        }
    }
}
