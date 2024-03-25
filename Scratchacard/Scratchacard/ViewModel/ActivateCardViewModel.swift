//
//  ActivateCardViewModel.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

struct ActivateCardFlow {
    let onSuccess: (ScratchCardState) -> Void
}

final class ActivateCardViewModel: ObservableObject {

    struct Dependencies {
        let activateCard: ActivateCardUseCase
    }

    private let deps: Dependencies
    private let flow: ActivateCardFlow
    private var task: Task<Void, Error>?

    @Published var cardState: ScratchCardState
    @Published var error: Error?
    @Published var isProgressing: Bool = false

    init(cardState: ScratchCardState, flow: ActivateCardFlow, deps: Dependencies) {
        self.cardState = cardState
        self.flow = flow
        self.deps = deps
    }

    @MainActor
    func activateCard() async {
        guard case let .scratched(code) = cardState else {
            error = ScratchCardError.invalidCardState
            return
        }

        task = Task { [weak self, flow, deps] in
            self?.isProgressing = true
            defer { self?.isProgressing = false }

            do {
                let result = try await deps.activateCard.activateCard(code: code)
                if result {
                    self?.cardState = .activated
                    flow.onSuccess(.activated)
                } else {
                    self?.error = ScratchCardError.activationFailed
                }
            } catch {
                self?.error = error
            }
        }
        try? await task?.value
    }

    @MainActor
    func onDisappear() {
    }
}
