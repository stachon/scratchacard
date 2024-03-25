//
//  HomeView.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Scratch Card State: \(viewModel.cardState.stateText)")

                Button("Go to Scratch Screen") {
                    // Navigation logic to ScratchScreen
                }

                Button("Go to Activation Screen") {
                    // Navigation logic to ActivationScreen
                }
            }
        }
    }
}

#Preview {
    return HomeView(viewModel: DefaultAssembly().makeHomeViewModel())
}
