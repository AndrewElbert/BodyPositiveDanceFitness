//
//  FaqItemComponent.swift
//  FaqUI
//
//  Created by Andrew Elbert on 1/31/25.
//

// import SwiftUI
//
// struct FaqItemComponent: View {
//
//    @ObservedObject private var viewModel: FaqViewModel
//
//    let question: String
//    let answer: String
//    let isExpanded: Bool
//    let isClosing: Bool
//    let toggleExpanded: () -> Void
//
//    public init(
//        viewModel: FaqViewModel,
//        question: String,
//        answer: String,
//        isExpanded: Bool,
//        isClosing: Bool,
//        toggleExpanded: @escaping () -> Void
//    ) {
//        self._viewModel = ObservedObject(wrappedValue: viewModel)
//        self.question = question
//        self.answer = answer
//        self.isExpanded = isExpanded
//        self.isClosing = isClosing
//        self.toggleExpanded = toggleExpanded
//    }
//
//    var body: some View {
//        FaqItem(
//        ) { action in
//            switch action {
//            case .updateShowText(let isClosing):
//                viewModel.updateShowText(isClosing: isClosing)
//            }
//        }
//    }
// }
