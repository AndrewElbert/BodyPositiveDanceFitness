//
//  NewcomersViewState.swift
//  NewcomersDomain
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct NewcomersViewState {
    var expandedQuestions: Set<Int> = []
    var closingIndex: Int?
    var faqItems: [Constants.NewComers.FAQItem] = Constants.NewComers.faqItems
}
