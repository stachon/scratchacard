//
//  MockScratchCardAPI.swift
//  ScratchacardTests
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation
@testable import Scratchacard

class MockScratchCardAPI: ScratchCardAPI {
    let result: Result<ActivateResponse, Error>
    let delay: Duration

    init(result: Result<ActivateResponse, Error>, delay: Duration = .zero) {
        self.result = result
        self.delay = delay
    }

    func activateCard(code: String) async throws -> Scratchacard.ActivateResponse {
        try await Task.sleep(for: delay, tolerance: .zero)
        try Task.checkCancellation()
        
        switch result {
        case .success(let response): return response
        case .failure(let error): throw error
        }
    }
}
