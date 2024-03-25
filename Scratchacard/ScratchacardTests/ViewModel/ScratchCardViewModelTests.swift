//
//  ScratchCardViewModelTests.swift
//  ScratchacardTests
//
//  Created by Martin Stachon on 25.03.2024.
//

import XCTest
@testable import Scratchacard

final class ScratchCardViewModelTests: XCTestCase {

    var viewModel: ScratchCardViewModel!

    var onSuccessState: ScratchCardState?

    func test__happyPath() async throws {
        let useCase = MockScratchCardUseCase(delay: .seconds(2), result: "123", throwError: false)
        viewModel = ScratchCardViewModel(cardState: .unscratched, flow: makeFlow(), deps: .init(scratchCard: useCase))

        let expectation = expectation(description: "Task finished")

        Task {
            await viewModel.scratchCard()
            expectation.fulfill()
        }

        try await Task.sleep(for: .milliseconds(500))

        XCTAssert(viewModel.isProgressing)

        await fulfillment(of: [expectation])

        switch viewModel.cardState {
        case .scratched(let code):
            XCTAssertEqual(code, "123")
        default:
            XCTFail("Invalid card state")
        }

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNil(viewModel.error)
    }

    func test__invalidInitialState() async throws {
        let useCase = MockScratchCardUseCase(delay: .seconds(2), result: "123", throwError: false)
        viewModel = ScratchCardViewModel(cardState: .scratched(code: "123456"), flow: makeFlow(), deps: .init(scratchCard: useCase))

        await viewModel.scratchCard()

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNotNil(viewModel.error)
    }

    func test__throwErrror() async throws {
        let useCase = MockScratchCardUseCase(delay: .seconds(2), result: "123", throwError: true)
        viewModel = ScratchCardViewModel(cardState: .unscratched, flow: makeFlow(), deps: .init(scratchCard: useCase))

        let expectation = expectation(description: "Task finished")

        Task {
            await viewModel.scratchCard()
            expectation.fulfill()
        }

        try await Task.sleep(for: .milliseconds(500))

        XCTAssert(viewModel.isProgressing)

        await fulfillment(of: [expectation])

        switch viewModel.cardState {
        case .unscratched:
            break
        default:
            XCTFail("Invalid card state")
        }

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNotNil(viewModel.error)
    }
}

extension ScratchCardViewModelTests {
    func makeFlow() -> ScratchCardFlow {
        return .init(onSuccess: { state in
            self.onSuccessState = state
        })
    }
}
