//
//  SetApp.swift
//  Set
//
//  Created by Abhinav Gupta on 18/06/21.
//

import SwiftUI

@main
struct SetApp: App {
    var game = SetGame.init()
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
