//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Abhinav Gupta on 18/05/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiGame
    
    var body: some View {
        VStack{
            Text(EmojiGame.currenttheme.themeName).font(.largeTitle).padding()
            ScrollView{
                 LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                    ForEach(viewModel.cards) { card in
                                CardView(card: card)
                                    .aspectRatio(2/3, contentMode: .fill)
                                    .onTapGesture {
                                        viewModel.choose(card)
                                    }
                    }
                 }.foregroundColor(EmojiGame.currenttheme.cardColor).font(.custom("PT Sans", size:50))
            }.padding(.horizontal)
            Spacer()
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game").font(.title)
            })
            Text("Score: \(viewModel.score)").font(.largeTitle).padding()
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if  card.isFaceUp {
                shape.fill(Color.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(EmojiGame.currenttheme.cardColor)
                Text("\(card.content)")
            }else if card.isMatched {
                shape.opacity(0)
            }else {
                shape.fill(EmojiGame.currenttheme.cardColor)
            }
        }
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGame()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
