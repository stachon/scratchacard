//
//  ScratchView.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import SwiftUI

struct ScratchView: View {
    @StateObject var viewModel: ScratchCardViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("Card State: \(viewModel.cardState.stateText)")

            if viewModel.isProgressing {
                ProgressView()
            } else {
                Button("Scratch it!") {
                    Task {
                        await viewModel.scratchCard()
                    }
                }
            }
        }
        .errorAlert(error: $viewModel.error)
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}
