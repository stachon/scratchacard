//
//  ScratchCardState.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

enum ScratchCardState {
    case unscratched
    case scratched(code: String)
    case activated

    var stateText: String {
        switch self {
        case .unscratched: return "Unscratched"
        case .scratched(let code): return "Scratched (\(code))"
        case .activated: return "Activated"
        }
    }
}

extension ScratchCardState: Equatable {}
