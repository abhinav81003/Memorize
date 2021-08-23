//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Abhinav Gupta on 18/05/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiGame.init(ID: nil)
    var body: some Scene {
        WindowGroup {
            WelcomePage()
        }
    }
}
