//
//  PreciseSequenceTimer.swift
//  Common
//
//  Created by Andrew Elbert on 3/8/25.
//

import Combine
import Foundation

class PreciseSequenceTimer {

    private var cancellable: AnyCancellable?
    private let baseInterval: Double
    private var startTime: Date?
    private var currentIteration = 0

    let publisher = PassthroughSubject<Date, Never>()

    init(baseInterval: Double) {
        self.baseInterval = baseInterval
    }

    func start() {

        cancel()

        startTime = Date()
        currentIteration = 0

        cancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] currentDate in
                guard let self = self, let startTime = self.startTime else { return }

                let nextIterationTime = self.calculateTimeForIteration(self.currentIteration + 1)

                let elapsedTime = currentDate.timeIntervalSince(startTime)
                if elapsedTime >= nextIterationTime {
                    self.currentIteration += 1
                    self.publisher.send(currentDate)
                }
            }
    }

    private func calculateTimeForIteration(_ iteration: Int) -> TimeInterval {
        return baseInterval * Double(iteration) - 1.6
    }

    func cancel() {
        cancellable?.cancel()
        cancellable = nil
        startTime = nil
    }

    deinit {
        cancel()
    }
}
