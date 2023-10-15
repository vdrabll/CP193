//
//  MemoryViewModel.swift
//  Memorize
//
//  Created by Виктория Федосова on 13.10.2023.
//

import SwiftUI

class EmojiViewModel: ObservableObject { // full separated viewmodel
	private static var emojies = ["🌸", "😍", "😘", "🎂", "🌸", "😍", "😘", "🎂"]
	
	private static func createMemoryGame() -> MemoryGame<String> {
		return MemoryGame(numberOfPairs: 4) { pairIndex in
			if emojies.indices.contains(pairIndex) {
				return  emojies[pairIndex]
			} else {
				return "ops"
			}
		}
	}
	
	@Published private var model = createMemoryGame() // если изменяется эта переменная она уведомляет
	
	var cards: Array<MemoryGame<String>.Card> {
		return model.cards
	}
	
	func shuffled() {
		model.shuffled()
	}
	
	func choose(_ card: MemoryGame<String>.Card) { // intend function
		return model.choose(card)
	}
}
