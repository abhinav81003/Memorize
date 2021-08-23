//MemoryGame.swift
//


import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    var score: Int
    var end: Bool
    
    mutating func choose(_ card: Card) {
        if let chosenindex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenindex].isFaceUp,
           !cards[chosenindex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenindex].content == cards[potentialMatchIndex].content{
                    cards[chosenindex].isMatched = true;
                    cards[potentialMatchIndex].isMatched = true;
                    score += 2
                    pairsofmatchedcards += 1
                } else if cards[chosenindex].previouslyseen && cards[potentialMatchIndex].previouslyseen{
                    score -= 2
                } else if cards[chosenindex].previouslyseen || cards[potentialMatchIndex].previouslyseen{
                    score -= 1
                    cards[chosenindex].previouslyseen = true
                    cards[potentialMatchIndex].previouslyseen = true
                }
                else {
                    cards[chosenindex].previouslyseen = true
                    cards[potentialMatchIndex].previouslyseen = true
                }
                cards[chosenindex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenindex
            }
        }
        if pairsofmatchedcards == allpairsofcards {
            end = true
        }
    }
    
    var pairsofmatchedcards: Int
    var allpairsofcards: Int
    
    init(numberOfPairsOfCards: Int, createCardContent: () -> Array<CardContent>){
        pairsofmatchedcards = 0
        allpairsofcards = numberOfPairsOfCards
        score = 0
        end = false
        let allcontent = createCardContent()
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = allcontent[pairIndex]
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards =  cards.shuffled()
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
        var previouslyseen = false
    }

}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}


struct GameThemes {
    
    private (set) var allthemes: Array<Theme>
    private (set) var currenttheme: Theme?
    
    init(allthemes: Array<Theme>, currenttheme: Theme?){
        self.allthemes = allthemes
        self.currenttheme = currenttheme
    }
    
    mutating func changetheme(){
        currenttheme = EmojiGame.themeslist.randomElement()
    }
    
    struct Theme{
        var themeName: String
        var numberOfCards: Int
        var cardColor: String
        var content: Array<String>
    }
    
}

