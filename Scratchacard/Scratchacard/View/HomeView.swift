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

                NavigationLink(destination: {
                    ScratchView(viewModel: viewModel.makeScratchViewModel())
                }, label: {
                    Text("Go to Scratching Screen")
                })

                NavigationLink(destination: {
                    ActivateView(viewModel: viewModel.makeActivateViewModel())
                }, label: {
                    Text("Go to Activation Screen")
                })
            }
        }
    }
}

#Preview {
    return HomeView(viewModel: DefaultAssembly().makeHomeViewModel())
}
