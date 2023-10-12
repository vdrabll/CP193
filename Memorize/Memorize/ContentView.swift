//
//  ContentView.swift
//  Memorize
//
//  Created by Виктория Федосова on 13.09.2023.
//

import SwiftUI

struct ContentView: View {
	private enum Themes {
		static let love = ["🌸", "😍", "😘", "🎂", "🌸", "😍", "😘", "🎂"]
		static let animals = ["🐻","🐣", "🐽", "🐼", "🐻", "🐣",
							  "🐽", "🐼", "🐷", "🐷", "🐮", "🐮"]
		static let flowers = ["🪸","💐", "🌷", "🪷", "🪸","💐","🌷", "🪷" ,
							  "🌾", "🌾", "🎋", "🎋", "🌻", "🌻"]
	}
	
	@State var cardCount = Themes.love.count
	@State var theme = Themes.love
	
	var body: some View {
		VStack {
			Text("Memorize!").font(.largeTitle).foregroundColor(.pink).bold()
			ScrollView {
				cards
			}
			Spacer()
			themeChooser
			
		}
		.padding()
	}
	
	var themeChooser: some View {
		HStack(spacing: 25) {
			buttonBilder(name: "love", image: "heart")
			buttonBilder(name: "animals", image: "swift")
			buttonBilder(name: "flowers", image: "globe.europe.africa")
		}.foregroundColor(.pink).font(.title3)
	}
	
	func setTheme(name: String) {
		switch name {
			case "love":
				self.theme = Themes.love.shuffled()
				self.cardCount = Themes.love.count
			case "animals":
				self.theme = Themes.animals.shuffled()
				self.cardCount = Themes.animals.count
			case "flowers":
				self.theme = Themes.flowers.shuffled()
				self.cardCount = Themes.flowers.count
				
			default:
				self.theme = Themes.love
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
	
	var cards: some View {
		LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 80), spacing: 10, alignment: .center), count: 4), content: {
			ForEach(0..<cardCount, id: \.self) { index in
				CarsView(content: theme[index])
					.aspectRatio(2/3, contentMode: .fit)
			}
		})
		.foregroundColor(.pink).font(.largeTitle)
		
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct CarsView: View {
	let content: String
	@State var isFaceUp: Bool = false
	var body: some View {
		ZStack {
			let base = RoundedRectangle(cornerRadius: 20)
			Group {
				base.strokeBorder(lineWidth: 10).foregroundColor(.pink)
				Text(content).font(.largeTitle)
			}.opacity(isFaceUp ? 1 : 0)
			base.fill().opacity(isFaceUp ? 0 : 1)
		}
		.onTapGesture{
			isFaceUp.toggle()
		}
	}
}
