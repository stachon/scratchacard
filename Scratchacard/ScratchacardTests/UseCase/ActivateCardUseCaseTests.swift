//
//  ActivateCardUseCaseTests.swift
//  ScratchacardTests
//
//  Created by Martin Stachon on 25.03.2024.
//

import XCTest
@testable import Scratchacard

final class ActivateCardUseCaseTests: XCTestCase {

    var mockApi: MockScratchCardAPI!
    var useCase: ActivateCardUseCaseImpl!

    func test__versionAboveReturnsTrue() async throws {
        mockApi = MockScratchCardAPI(result: .success(ActivateResponse(ios: "6.2")))
        useCase = ActivateCardUseCaseImpl(deps: .init(api: mockApi))
        let result = try await useCase.activateCard(code: "123")
        XCTAssertEqual(result, true)
    }

    func test__versionBelowReturnsFalse() async throws {
        mockApi = MockScratchCardAPI(result: .success(ActivateResponse(ios: "6.1")))
        useCase = ActivateCardUseCaseImpl(deps: .init(api: mockApi))
        let result = try await useCase.activateCard(code: "123")
        XCTAssertEqual(result, false)
    }

}
