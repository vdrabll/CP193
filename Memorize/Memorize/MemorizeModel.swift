//
//  MemorizeModel.swift
//  Memorize
//
//  Created by Виктория Федосова on 12.10.2023.
//

import Foundation

struct MemoryGame<CardContent> {
	private(set) var cards: Array<Card>
	
	init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
		cards = []
		for pairIndex in 0..<max(2, numberOfPairs) {
			let content: CardContent = cardContentFactory(pairIndex)
			cards.append(Card(content: content))
			cards.append(Card(content: content))
		}
	}
	
	func choose(_ card: Card) {
		
	}
	
	mutating func shuffled()  {
		cards.shuffle()
	}
	
	struct Card {
		var isFaseUp = true
		var isMatched = false
		let content: CardContent
	}
}
