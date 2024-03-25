//
//  ScratchCardError.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

enum ScratchCardError: LocalizedError {
    case networkError
    case invalidResponse
    case activationFailed
    case invalidCardState

    var errorDescription: String? {
        switch self {
        case .networkError: "Network Error"
        case .invalidResponse: "Invalid response returned from server"
        case .activationFailed: "Activation failed"
        case .invalidCardState: "Invalid card state for this operation"
        }
    }
}
