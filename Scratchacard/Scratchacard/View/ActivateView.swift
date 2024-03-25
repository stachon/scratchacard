//
//  ActivateView.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import SwiftUI

struct ActivateView: View {
    @StateObject var viewModel: ActivateCardViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("Card State: \(viewModel.cardState.stateText)")

            if viewModel.isProgressing {
                ProgressView()
            } else {
                Button("Activate") {
                    Task {
                        await viewModel.activateCard()
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
