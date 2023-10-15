//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Виктория Федосова on 13.09.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
	@StateObject var game = EmojiViewModel()
	
    var body: some Scene {
        WindowGroup {
            MemorizeView( viewModel: game)
        }
    }
}
