//
//  ScratchCardUseCase.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

protocol ScratchCardUseCase {
    func scratch() async throws -> String
}

class ScratchCardUseCaseImpl: ScratchCardUseCase {
    func scratch() async throws -> String {
        try await Task.sleep(for: .seconds(2), tolerance: .zero)
        try Task.checkCancellation()
        return UUID().uuidString
    }
}
