//
//  ScratchCardViewModel.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

struct ScratchCardFlow {
    let onSuccess: (ScratchCardState) -> Void
}

final class ScratchCardViewModel: ObservableObject {

    struct Dependencies {
        let scratchCard: ScratchCardUseCase
    }

    private let deps: Dependencies
    private let flow: ScratchCardFlow
    private var scratchTask: Task<Void, Error>?

    @Published var cardState: ScratchCardState
    @Published var error: Error?
    @Published var isProgressing: Bool = false

    init(cardState: ScratchCardState, flow: ScratchCardFlow, deps: Dependencies) {
        self.cardState = cardState
        self.flow = flow
        self.deps = deps
    }

    @MainActor
    func scratchCard() async {
        guard case .unscratched = cardState else {
            error = ScratchCardError.invalidCardState
            return
        }

        scratchTask = Task {
            isProgressing = true
            defer {
                isProgressing = false
            }
            do {
                let code = try await deps.scratchCard.scratch()
                self.cardState = .scratched(code: code)
                flow.onSuccess(cardState)
            } catch {
                self.error = error
            }
        }
        try? await scratchTask?.value
    }

    @MainActor
    func onDisappear() {
        scratchTask?.cancel()
    }
}
