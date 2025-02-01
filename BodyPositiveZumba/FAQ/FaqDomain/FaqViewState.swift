//
//  FaqViewState.swift
//  FaqDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct FaqViewState {

    var expandedQuestions: Set<Int> = []
    var closingIndex: Int?
    let faqItems = Constants.FAQ.faqItems

    var showText = false
}
