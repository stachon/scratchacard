//
//  ScratchCardViewModel.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

class HomeViewModel: ObservableObject {

    struct Dependencies {
        let assembly: Assembly
    }
    let deps: Dependencies

    @Published var cardState: ScratchCardState = .unscratched

    init(deps: Dependencies) {
        self.deps = deps
    }
    
    func makeScratchViewModel() -> ScratchCardViewModel {
        let flow = ScratchCardFlow(onSuccess: { [weak self] state in
            self?.cardState = state
        })
        return deps.assembly.makeScratchCardViewModel(cardState: cardState, flow: flow)
    }

    func makeActivateViewModel() -> ActivateCardViewModel {
        let flow = ActivateCardFlow(onSuccess: { [weak self] state in
            self?.cardState = state
        })
        return deps.assembly.makeActivateCardViewModel(cardState: cardState, flow: flow)
    }
}
