//
//  ActivateScratchCardUseCase.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

protocol ActivateCardUseCase {
    func activateCard(code: String) async throws -> Bool
}

class ActivateScratchCardUseCaseImpl: ActivateCardUseCase {
    
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
        guard let version = Double(response.ios) else {
            throw ScratchCardError.invalidResponse
        }
        return version > Constants.minRequiredVersion
    }
}
