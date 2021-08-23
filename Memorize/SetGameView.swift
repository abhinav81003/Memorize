//
//  ContentView.swift
//  Set
//
//  Created by Abhinav Gupta on 18/06/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGame
    @Namespace private var cardNameSpace
    @State var ShowCards: Bool = false
    @State var showAlert = false
    var body: some View {
        VStack{
            Text("Sets").font(.largeTitle).bold().padding()
            HStack{
                if game.gameCards.count < 33 {
                    AspectVGrid(items: game.gameCards, aspectRatio: 2/3){ card in
                        if ShowCards {
                            SetCardView(card: card, game: game).onTapGesture{
                                withAnimation(Animation.linear(duration: 0.5)) {
                                    game.choose(card)
                                    if game.endgame {
                                        self.showAlert.toggle()
                                    }
                                }
                            }
                            .padding(2.9)
                            .foregroundColor(Color.yellow)
                            .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                        }
                    }.onAppear(perform: { withAnimation(.linear(duration: 1)){
                        ShowCards.toggle()
                        }})
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum:50))]){
                            ForEach(game.gameCards){ card in
                                SetCardView(card: card, game: game)
                                    .onTapGesture{
                                        withAnimation(Animation.linear(duration: 0.5)) {
                                            game.choose(card)
                                            if game.endgame {
                                                self.showAlert.toggle()
                                            }
                                        }
                                    }
                                    .foregroundColor(Color.yellow).aspectRatio(2/3, contentMode: .fit)
                            }
                        }
                        .onAppear(perform: { withAnimation(.linear){
                            ShowCards.toggle()
                            }})
                    }
                }
                Spacer(minLength: 0)
            }.layoutPriority(100)
            .alert(isPresented: $showAlert) { () -> Alert in
                           let button = Alert.Button.default(Text("New Game")) { game.newGame() }
                           return Alert(title: Text("Congratulations")
                               , message: Text("You have successfully finished this game"), dismissButton: button)
            }
            HStack{
                ZStack{
                    if game.deck.count > game.gameCards.count{
                        ForEach(game.deck){card in
                            let visiblecard_index = game.gameCards.firstIndex(where: {$0.id == card.id})
                            if visiblecard_index == nil {
                                SetCardView(card: card, game: game).aspectRatio(2/3, contentMode: .fit)
                                    .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                                    .onTapGesture {
                                        withAnimation {
                                            game.add3cards()
                                        }
                                    }
                            }
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 20).foregroundColor(.gray)
                    }
                }.padding()
                Spacer()
                DiscardedCardView(game: game)
            }
            HStack{
                shuffleButton.padding(.top, 20)
                Spacer()
                Button(action: {game.newGame()}, label: {
                    Text("New Game")
                })
            }.padding(.horizontal)
            
        }.padding()
        .navigationBarItems(trailing: Button(action: { game.newGame() } , label: {Text("New Game").font(.body)}).padding())
    }
    
    var shuffleButton: some View {
        HStack{
            Button(action: {withAnimation { game.shuffle() } }, label: {
                HStack {
                    Image(systemName: "shuffle")
                    Text("Shuffle")
                }
            })
        }
    }
}


struct DiscardedCardView: View {
    var game: SetGame
    var body: some View{
        ZStack{
            ForEach(game.discarded){ card in
                SetCardView(card: card, game: game)
            }.aspectRatio(2/3,contentMode: .fill)
        }
    }
}
struct SetCardView: View {
    var card: SetLogic.SetCards
    var game: SetGame
    var body: some View{
            ZStack{
                switch(card.NumberOfShapes){
                case 2:
                    twoShapeStack(game: game, card: card).padding(15)
                case 3:
                    threeShapeStack(game: game, card: card).padding(15)
                default:
                    oneShapeStack(game: game, card: card).padding(15)
                }
            }
            .Face(isFaceUp: card.isFaceUp ? true : false, failedMatch: card.failedMatched ? true : false, isMatched: card.isMatched ? true : false)
    }
}

struct SetView_Preview: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        return SetGameView(game: game)
    }
}
