//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Abhinav Gupta on 18/05/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiGame
    @State var showAlert = false
    var body: some View {
        gameBody
    }
    var gameBody: some View {
        VStack {
            Text(game.actualtheme.themeName).font(.largeTitle).fontWeight(.bold).padding(.horizontal)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card, game: game)
                            .padding(4)
                            .dissappear(isMatched: card.isMatched ? true : false)
                            .onTapGesture {
                                withAnimation {
                                    game.choose(card)
                                }
                                if game.end {
                                    self.showAlert.toggle()
                                }
                            }
            }
            shuffle
            if !game.end {
                Text("Score: \(game.score)").font(.title).fontWeight(.semibold).padding()
            }
        }.navigationBarItems(trailing: Button(action: { game.new() }
                                             , label: {Text("New Game").font(.body)}).padding())
         .padding()
         .alert(isPresented: $showAlert) { () -> Alert in
                        let button = Alert.Button.default(Text("New Game")) { game.new() }
                        return Alert(title: Text("Congratulations")
                            , message: Text("You have finished this game with a score of: \(game.score)"), dismissButton: button)
         }
    }
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.linear){
                game.shuffle()
            }
        }
    }
}


struct CardView: View {
    let card: EmojiGame.Card
    var game: EmojiGame
    var body: some View{
        GeometryReader{ geometry in
                ZStack {
                        Pie(startAngle: Angle(degrees: -90) , endAngle: Angle(degrees: 30))
                            .foregroundColor(game.cardColor).opacity(DrawingConstants.PieOpacity).padding(DrawingConstants.PiePadding)
                        Text("\(card.content)").font(font(in: geometry.size))
                        
                }
                .cardify(isFaceUp:card.isFaceUp ? true : false)
                .foregroundColor(game.cardColor)
        }
    }
    
    private func font(in size: CGSize) ->Font{
        Font.system(size: min(size.width, size.height) * DrawingConstants.EmojiScale)
    }
    
    private struct DrawingConstants{
       // static let cornerRadius: CGFloat = 10
       // static let lineWidth: CGFloat = 3
        static let EmojiScale: CGFloat = 0.7
        static let PiePadding: CGFloat = 5
        static let PieOpacity: Double = 0.5
    }
}
















struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGame(ID: nil)
        return EmojiMemoryGameView(game: game)
    }
}
