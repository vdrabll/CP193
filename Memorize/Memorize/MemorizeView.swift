//
//  ContentView.swift
//  Memorize
//
//  Created by Виктория Федосова on 13.09.2023.
//

import SwiftUI

struct MemorizeView: View {
	private enum Themes {
		static let love = ["🌸", "😍", "😘", "🎂", "🌸", "😍", "😘", "🎂"]
		static let animals = ["🐻","🐣", "🐽", "🐼", "🐻", "🐣",
							  "🐽", "🐼", "🐷", "🐷", "🐮", "🐮"]
		static let flowers = ["🪸","💐", "🌷", "🪷", "🪸","💐","🌷", "🪷" ,
							  "🌾", "🌾", "🎋", "🎋", "🌻", "🌻"]
	}
	
	@State var cardCount = Themes.love.count
	@State var theme = Themes.love
	@State var color = Color.pink
	
	@ObservedObject var viewModel: EmojiViewModel // если что то изменилось - перепиши меня
	var body: some View {
		VStack {
			Text("Memorize!").font(.largeTitle).foregroundColor(color).bold()
			ScrollView {
				cards
			}
			Spacer()
			Button {
				viewModel.shuffled()
			} label: {
				Text("Shuffle")
			}

		}
		.padding()
	}
	
	var themeChooser: some View {
		HStack(spacing: 25) {
			buttonBilder(name: "love", image: "heart").foregroundColor(.pink)
			buttonBilder(name: "animals", image: "swift").foregroundColor(.brown)
			buttonBilder(name: "flowers", image: "globe.europe.africa").foregroundColor(.mint)
		}.font(.title3)
	}
	
	var cards: some View {
		LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 85),
													 spacing: 10,
													 alignment: .center),
								 count: 2), content: {
			ForEach(viewModel.cards.indices, id: \.self) { index in
				CarsView(card: viewModel.cards[index])
					.aspectRatio(2/3, contentMode: .fit)
			}
		})
		.foregroundColor(color).font(.largeTitle)
		
	}
	func shuffle() {
		viewModel.shuffled()
	}
	
	func setTheme(name: String) {
		switch name {
			case "love":
				self.theme = Themes.love.shuffled()
				self.cardCount = Themes.love.count
				self.color = Color.pink
			case "animals":
				self.theme = Themes.animals.shuffled()
				self.cardCount = Themes.animals.count
				self.color = Color.brown
			case "flowers":
				self.theme = Themes.flowers.shuffled()
				self.cardCount = Themes.flowers.count
				self.color = Color.mint
			default:
				self.theme = Themes.love
				self.color = Color.pink
		}
	}
	
	func buttonBilder(name: String, image title: String) -> some View {
		Button {
			setTheme(name: name)
		} label: {
			VStack {
				Image(systemName: title)
				Text(name)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		MemorizeView(viewModel: EmojiViewModel())
	}
}

struct CarsView: View {
	var card: MemoryGame<String>.Card
	
	init(card: MemoryGame<String>.Card) {
		self.card = card
	}
	var body: some View {
		ZStack {
			let base = RoundedRectangle(cornerRadius: 20)
			base.strokeBorder(lineWidth: 10)
			Group {
				Text(card.content).font(.largeTitle)
					.font(.system(size: 200))
					.minimumScaleFactor(0.01)
					.aspectRatio(1, contentMode: .fill)
			}
			.opacity(card.isFaseUp ? 1 : 0)
			base.fill().opacity(card.isFaseUp ? 0 : 1)
		}
	}
}
