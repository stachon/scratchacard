//
//  ActivateCardViewModelTests.swift
//  ScratchacardTests
//
//  Created by Martin Stachon on 25.03.2024.
//

import XCTest
@testable import Scratchacard

final class ActivateCardViewModelTests: XCTestCase {

    var viewModel: ActivateCardViewModel!

    var onSuccessState: ScratchCardState?

    func test__happyPath() async throws {
        let api = MockScratchCardAPI(result: .success(.init(ios: "6.2")), delay: .seconds(1))
        let useCase = ActivateCardUseCaseImpl(deps: .init(api: api))
        viewModel = ActivateCardViewModel(cardState: .scratched(code: "123"), flow: makeFlow(), deps: .init(activateCard: useCase))

        let expectation = expectation(description: "Task finished")

        Task {
            await viewModel.activateCard()
            expectation.fulfill()
        }

        try await Task.sleep(for: .milliseconds(500))

        XCTAssert(viewModel.isProgressing)

        await fulfillment(of: [expectation])

        switch viewModel.cardState {
        case .activated:
            break
        default:
            XCTFail("Invalid card state")
        }

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNil(viewModel.error)
    }

    func test__lowerVersionProducesError() async throws {
        let api = MockScratchCardAPI(result: .success(.init(ios: "6.1")), delay: .seconds(1))
        let useCase = ActivateCardUseCaseImpl(deps: .init(api: api))
        viewModel = ActivateCardViewModel(cardState: .scratched(code: "123"), flow: makeFlow(), deps: .init(activateCard: useCase))

        let expectation = expectation(description: "Task finished")

        Task {
            await viewModel.activateCard()
            expectation.fulfill()
        }

        try await Task.sleep(for: .milliseconds(500))

        XCTAssert(viewModel.isProgressing)

        await fulfillment(of: [expectation])

        switch viewModel.cardState {
        case .scratched:
            break
        default:
            XCTFail("Invalid card state")
        }

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNotNil(viewModel.error)
    }

    func test__invalidInitialState() async throws {
        let api = MockScratchCardAPI(result: .success(.init(ios: "6.2")), delay: .seconds(1))
        let useCase = ActivateCardUseCaseImpl(deps: .init(api: api))
        viewModel = ActivateCardViewModel(cardState: .activated, flow: makeFlow(), deps: .init(activateCard: useCase))

        await viewModel.activateCard()

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNotNil(viewModel.error)
    }

    func test__throwErrror() async throws {
        let api = MockScratchCardAPI(result: .failure(ScratchCardError.networkError), delay: .seconds(1))
        let useCase = ActivateCardUseCaseImpl(deps: .init(api: api))
        viewModel = ActivateCardViewModel(cardState: .scratched(code: "123"), flow: makeFlow(), deps: .init(activateCard: useCase))

        let expectation = expectation(description: "Task finished")

        Task {
            await viewModel.activateCard()
            expectation.fulfill()
        }

        try await Task.sleep(for: .milliseconds(500))

        XCTAssert(viewModel.isProgressing)

        await fulfillment(of: [expectation])

        switch viewModel.cardState {
        case .scratched:
            break
        default:
            XCTFail("Invalid card state")
        }

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNotNil(viewModel.error)
    }

    func test__dismissWillNotCancelOperation() async throws {
        let api = MockScratchCardAPI(result: .success(.init(ios: "6.2")), delay: .seconds(1))
        let useCase = ActivateCardUseCaseImpl(deps: .init(api: api))
        viewModel = ActivateCardViewModel(cardState: .scratched(code: "123"), flow: makeFlow(), deps: .init(activateCard: useCase))

        let expectation = expectation(description: "Task finished")

        Task {
            await viewModel.activateCard()
            expectation.fulfill()
        }

        try await Task.sleep(for: .milliseconds(500))

        await viewModel.onDisappear()

        XCTAssert(viewModel.isProgressing)

        await fulfillment(of: [expectation])

        switch viewModel.cardState {
        case .activated:
            break
        default:
            XCTFail("Invalid card state")
        }

        XCTAssert(!viewModel.isProgressing)
        XCTAssertNil(viewModel.error)
    }
}

extension ActivateCardViewModelTests {
    func makeFlow() -> ActivateCardFlow {
        return .init(onSuccess: { state in
            self.onSuccessState = state
        })
    }
}

