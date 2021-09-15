//
//  SetGameApp.swift
//  SetGame
//
//  Created by Adam Petro on 21/08/2021.
//


// FIX: When no cards in deck remaining and you find a set, game crashes
import SwiftUI

@main
struct SetGameApp: App {
    let viewModel = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
