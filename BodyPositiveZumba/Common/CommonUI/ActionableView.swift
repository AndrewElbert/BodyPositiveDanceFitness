//
//  ActionableView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

protocol ActionableView {
    
    associatedtype Action
    
    typealias ActionClosure = ((Action) -> Void)?
    
    var onAction: ActionClosure { get set}
}
