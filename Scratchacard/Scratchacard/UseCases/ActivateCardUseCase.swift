//
//  ActivateCardUseCase.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

protocol ActivateCardUseCase {
    func activateCard(code: String) async throws -> Bool
}

class ActivateCardUseCaseImpl: ActivateCardUseCase {
    
    struct Dependencies {
        let api: ScratchCardAPI
    }
    let deps: Dependencies

    struct Constants {
        static let minRequiredVersion = 6.1
    }

    init(deps: Dependencies) {
        self.deps = deps
    }

    func activateCard(code: String) async throws -> Bool {
        let response = try await deps.api.activateCard(code: code)
        // note this is not a proper version check, but it fulfills the assignment
        guard let version = Double(response.ios) else {
            throw ScratchCardError.invalidResponse
        }
        return version > Constants.minRequiredVersion
    }
}
