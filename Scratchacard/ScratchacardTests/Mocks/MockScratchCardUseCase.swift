//
//  File.swift
//  ScratchacardTests
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation
@testable import Scratchacard

class MockScratchCardUseCase : ScratchCardUseCase {

    let delay: Duration
    let result: String
    let throwError: Bool

    init(delay: Duration, result: String, throwError: Bool) {
        self.delay = delay
        self.result = result
        self.throwError = throwError
    }

    func scratch() async throws -> String {
        try await Task.sleep(for: delay, tolerance: .zero)
        try Task.checkCancellation()
        if throwError {
            throw ScratchCardError.invalidResponse
        }
        return result
    }
}
