//
//  ScratchCardViewModel.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

class ScratchCardViewModel: ObservableObject {

    struct Dependencies {
        let activateCard: ActivateCardUseCase
    }

    let deps: Dependencies

    @Published var cardState: ScratchCardState = .unscratched
    @Published var error: Error?

    init(deps: Dependencies) {
        self.deps = deps
    }

    func scratchCard() async {
        do {
            try await Task.sleep(for: .seconds(2), tolerance: .zero)
            self.cardState = .scratched(code: UUID().uuidString)
        } catch {
            self.error = error
        }
    }

    func activateCard(code: String) async throws {
        do {
            let result = try await deps.activateCard.activateCard(code: code)
            if result {
                cardState = .activated
            } else {
                error = ScratchCardError.activationFailed
            }
        } catch {
            self.error = error
        }
    }
}
