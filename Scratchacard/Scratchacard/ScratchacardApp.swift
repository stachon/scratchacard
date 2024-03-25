//
//  ScratchacardApp.swift
//  Scratchacard
//
//  Created by Martin Stachon on 25.03.2024.
//

import SwiftUI

let assembly = DefaultAssembly()
let viewModel = assembly.makeHomeViewModel()

@main
struct ScratchacardApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
