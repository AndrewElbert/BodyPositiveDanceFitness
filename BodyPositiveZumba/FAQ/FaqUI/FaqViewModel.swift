//
//  FaqViewModel.swift
//  Faq
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

@MainActor
class FaqViewModel: ObservableObject {

    @Published var viewState = FaqViewState()

    func toggleQuestion(_ index: Int) {
        if viewState.expandedQuestions.contains(index) {
            viewState.closingIndex = index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.viewState.expandedQuestions.remove(index)
                self.viewState.closingIndex = nil
            }
        } else {
            viewState.expandedQuestions.insert(index)
        }
    }
}
