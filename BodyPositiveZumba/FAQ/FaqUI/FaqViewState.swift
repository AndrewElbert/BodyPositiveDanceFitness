//
//  FaqViewState.swift
//  Faq
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct FaqViewState {
    
    var expandedQuestions: Set<Int> = []
    var closingIndex: Int?

    var faqItems: [FaqItemViewState]

    init() {
        self.faqItems = Constants.FAQ.faqItems.enumerated().map { _, item in
            FaqItemViewState(
                question: item.question,
                answer: item.answer
            )
        }
    }
}
