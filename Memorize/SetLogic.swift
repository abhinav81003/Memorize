//  Created by Abhinav Gupta on 18/06/21.

import Foundation

struct SetLogic {
    
    var Cards: Array<SetCards>
    var VisibleCards: Array<SetCards>
    var DiscardedCards: Array<SetCards>
    var justMatched = false
    var endgame = false
    
    init(TotalCards: Int, NumberOfCards: Int, ShapeNames: Array<ShapeNames>, Shadings: Array<Shadings>, Colors: Array<String>){
        Cards = []
        var id = 1
        for index in 1...NumberOfCards{
            for shapeName in ShapeNames{
                for shading in Shadings{
                    for color in Colors{
                        Cards.append(SetCards(id: id, NumberOfShapes: index, ShapeName: shapeName, Color: color, Shading: shading))
                        id += 1
                    }
                }
            }
        }
        Cards = Cards.shuffled()
        VisibleCards = Array(Cards[..<TotalCards])
        DiscardedCards = []
    }
    
    
    mutating func choose(card: SetCards){
        let chosenIndex = VisibleCards.firstIndex(where: {$0.id == card.id})
        var faceUpCards = VisibleCards.OneOrTwoOrThree(where: {$0.isFaceUp == true})
        var shapes: Array<ShapeNames> = []
        var numbers: Array<Int> = []
        var colors:  Array<String> = []
        var shadings: Array<Shadings> = []
        if faceUpCards.count == 0 {
            for index in VisibleCards.indices{
                VisibleCards[index].isFaceUp = false
            }
            if let chosenIndex = chosenIndex{
                VisibleCards[chosenIndex].isFaceUp.toggle()
            }
        } else if faceUpCards.count == 1 {
            VisibleCards[chosenIndex!].isFaceUp.toggle()
        } else if faceUpCards.count == 2 {
            VisibleCards[chosenIndex!].isFaceUp.toggle()
            if VisibleCards[chosenIndex!].isFaceUp == true {
                let first = VisibleCards.firstIndex(where: {$0.id == faceUpCards[0].id})
                let second = VisibleCards.firstIndex(where: {$0.id == faceUpCards[1].id})
                faceUpCards = [VisibleCards[first!], VisibleCards[second!], VisibleCards[chosenIndex!]]
                for card in faceUpCards{
                    shapes.append(card.ShapeName)
                    numbers.append(card.NumberOfShapes)
                    colors.append(card.Color)
                    shadings.append(card.Shading)
                }
                if shapes.allEqualOrUnequal() && numbers.allEqualOrUnequal() && colors.allEqualOrUnequal() && shadings.allEqualOrUnequal() {
                    VisibleCards[first!].isMatched = true
                    VisibleCards[second!].isMatched = true
                    VisibleCards[chosenIndex!].isMatched = true
                    let firstCardIndexDeck = Cards.firstIndex(where: {$0.id == VisibleCards[first!].id})
                    let secondCardIndexDeck = Cards.firstIndex(where: {$0.id == VisibleCards[second!].id})
                    let thirdCardIndexDeck = Cards.firstIndex(where: {$0.id == VisibleCards[chosenIndex!].id})
                    if let first = firstCardIndexDeck, let second = secondCardIndexDeck, let third = thirdCardIndexDeck {
                        Cards[first].isMatched = true
                        Cards[second].isMatched = true
                        Cards[third].isMatched = true
                    }
                    justMatched = true
                } else {
                    VisibleCards[first!].failedMatched = true
                    VisibleCards[second!].failedMatched = true
                    VisibleCards[chosenIndex!].failedMatched = true
                    justMatched = false
                }
                if Cards.count == 3 {
                   endgame = true
                }
            }
        } else if faceUpCards.count == 3 {
            if justMatched == true {
                var isANonMatchedCard = false
                for index in 0...2 {
                    if faceUpCards[index].id != VisibleCards[chosenIndex!].id {
                        isANonMatchedCard = true
                    } else {
                        isANonMatchedCard = false
                        break
                    }
                }
                if isANonMatchedCard  {
                    if isANonMatchedCard {
                        var index = 0
                        while index < VisibleCards.count {
                            if VisibleCards[index].isMatched == true {
                                    let CardIndex = Cards.firstIndex(where: {$0.id == VisibleCards[index].id})
                                    DiscardedCards.append(VisibleCards[index])
                                for index in DiscardedCards.indices{
                                        DiscardedCards[index].isFaceUp = true
                                    }
                                    VisibleCards.remove(at: index)
                                    Cards.remove(at: CardIndex ?? Cards.startIndex)
                                    index -= 1
                            }
                            index += 1
                        }
                        justMatched = false
                    }
                }
            } else {
                for index in VisibleCards.indices{
                    VisibleCards[index].isFaceUp = false
                    VisibleCards[index].failedMatched = false
                }
                if let chosenIndex = chosenIndex{
                    VisibleCards[chosenIndex].isFaceUp.toggle()
                }
            }
        }
    }
    
    mutating func shuffle() {
        VisibleCards.shuffle()
    }
    
    mutating func addCards(_ numberOfCards: Int, at : Int?) {
        var position:Array<Int> = []
        let faceUpCards = VisibleCards.OneOrTwoOrThree(where: {$0.isFaceUp == true})
        if justMatched && faceUpCards.count == 3 {
            for index in faceUpCards.indices {
                position.append(VisibleCards.firstIndex(where: {$0.id == faceUpCards[index].id})!)
            }
        } else {
            position = Array(repeating: at ?? VisibleCards.endIndex, count: numberOfCards)
        }
        if VisibleCards.count < Cards.count {
            var additionalCards: Array<SetCards> = []
            for card in Cards {
                if !card.isMatched {
                    additionalCards.append(card)
                }
            }
            for visiblecard in VisibleCards {
                additionalCards.removeAll(where: {$0.id == visiblecard.id})
            }
            additionalCards = additionalCards.shuffled()
            for index in 0 ..< numberOfCards {
                if justMatched && (faceUpCards.count != 0) {
                    Cards.remove(at: Cards.firstIndex(where: {$0.id == VisibleCards[position[index]].id})!)
                    VisibleCards.remove(at: position[index])
                }
                VisibleCards.insert(additionalCards[index], at: position[index])
            }
        } else {
            for index in 0 ..< numberOfCards {
                if justMatched {
                    VisibleCards.remove(at: position[index])
                }
            }
        }
    }
    
    struct SetCards: Identifiable{
        var id: Int
        var NumberOfShapes: Int
        var ShapeName: ShapeNames
        var Color: String
        var Shading: Shadings
        var isFaceUp = false
        var isMatched = false
        var failedMatched = false
    }
    
    enum ShapeNames{
        case Oval, Swirly, Diamond
    }
    
    enum Shadings{
        case fill, open, striped
    }
}

extension Array {
    func OneOrTwoOrThree(where condition: (Element)-> Bool) -> [Element] {
        var conditionTrueElements: [Element] = []
        for index in self.indices{
            if condition(self[index]) == true {
                conditionTrueElements.append(self[index])
            }
        }
        if conditionTrueElements.count == 1 || conditionTrueElements.count == 2 || conditionTrueElements.count == 3{
            return conditionTrueElements
        }
        return []
    }
    
    func allEqualOrUnequal() -> Bool where Element: Equatable{
        let firstValue: Element = self[0]
        let secondValue: Element = self[1]
        let thirdValue: Element = self[2]
        var equalOrUnequal: Bool = false
        for element in self{
            if element == firstValue{
                equalOrUnequal = true
            } else {
                equalOrUnequal = false
                break
            }
        }
        if !equalOrUnequal {
//            for index in self[1..<endIndex].indices{
//                for previousIndex in self[0..<index].indices{
//                    if self[index] != self[previousIndex]{
//                        equalOrUnequal = true
//                    }else{
//                        equalOrUnequal = false
//                        break
//                    }
//                }
//                break
//            }
            if firstValue != secondValue && thirdValue != firstValue && thirdValue != secondValue{
                equalOrUnequal = true
            } else{
                equalOrUnequal = false
            }
        }
       return equalOrUnequal
    }
}

