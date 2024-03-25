//
//  DefaultAssembly.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import Foundation

protocol Assembly {

    func makeHomeViewModel() -> HomeViewModel

    func makeActivateCardViewModel(cardState: ScratchCardState, flow: ActivateCardFlow) -> ActivateCardViewModel

    func makeScratchCardViewModel(cardState: ScratchCardState, flow: ScratchCardFlow) -> ScratchCardViewModel

}

class DefaultAssembly: Assembly {
    
    let api: ScratchCardAPI

    init() {
        api = ScratchCardAPIImpl()
    }

    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(deps: .init(assembly: self))
    }

    func makeActivateCardViewModel(cardState: ScratchCardState, flow: ActivateCardFlow) -> ActivateCardViewModel {
        let useCase = ActivateCardUseCaseImpl(deps: .init(api: api))
        return ActivateCardViewModel(cardState: cardState, flow: flow, deps: .init(activateCard: useCase))
    }

    func makeScratchCardViewModel(cardState: ScratchCardState, flow: ScratchCardFlow) -> ScratchCardViewModel {
        let useCase = ScratchCardUseCaseImpl()
        return ScratchCardViewModel(cardState: cardState, flow: flow, deps: .init(scratchCard: useCase))
    }

}
