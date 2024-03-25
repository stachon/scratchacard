//
//  ScratchCardAPI.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation
import Alamofire

protocol ScratchCardAPI {
    func activateCard(code: String) async throws -> ActivateResponse
}

class ScratchCardAPIImpl: ScratchCardAPI {

    private let apiBase = "https://api.o2.sk"

    func activateCard(code: String) async throws -> ActivateResponse {
        let parameters = ["code": code]
        let task = AF.request(apiBase +  "/version", parameters: parameters)
            .serializingDecodable(ActivateResponse.self)

        return try await task.value
    }
}
