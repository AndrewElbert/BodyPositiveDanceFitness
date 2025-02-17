//
//  ActionableView.swift
//  Common
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

protocol ActionableView {

    typealias ActionClosure = ( (Action) -> Void )?

    associatedtype Action

    var onAction: ActionClosure { get set }
}
