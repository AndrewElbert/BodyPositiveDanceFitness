//
//  CoordinatorTransitionDelay.swift
//  Coordinator
//
//  Created by Andrew Elbert on 1/29/25.
//

import Foundation

public protocol CoordinatorTransitionDelay {

    var transitionDelay: DispatchTimeInterval { get }

    func delayTransition(completion: @escaping () -> Void)
}

public extension CoordinatorTransitionDelay {

    var transitionDelay: DispatchTimeInterval {
        return .milliseconds(333)
    }

    func delayTransition(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDelay) {
            completion()
        }
    }
}
