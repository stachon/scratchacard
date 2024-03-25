//
//  ScratchCardUseCaseTests.swift
//  ScratchacardTests
//
//  Created by Martin Stachon on 25.03.2024.
//

import XCTest
@testable import Scratchacard

final class ScratchCardUseCaseTests: XCTestCase {

    var useCase: ScratchCardUseCase!

    func test__returnsString() async throws {
        useCase = ScratchCardUseCaseImpl()
        let result = try await useCase.scratch()
        XCTAssert(!result.isEmpty)
    }

}
