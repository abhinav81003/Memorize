//
//  SetGame.swift
//  Set
//
//  Created by Abhinav Gupta on 18/06/21.
//

import SwiftUI

class SetGame: ObservableObject {
    
    @Published var model: SetLogic = SetGame.createModel()
    
    static func createModel() -> SetLogic {
        return SetLogic(TotalCards: 12, NumberOfCards: 3, ShapeNames: [SetLogic.ShapeNames.Oval,SetLogic.ShapeNames.Swirly,SetLogic.ShapeNames.Diamond], Shadings: [SetLogic.Shadings.fill, SetLogic.Shadings.open, SetLogic.Shadings.striped], Colors: ["red","purple","green"])
    }
    
     var gameCards: Array<SetLogic.SetCards>{
        return model.VisibleCards
    }
    
    var discarded: Array<SetLogic.SetCards>{
        return model.DiscardedCards
    }
    
    var deck: Array<SetLogic.SetCards>{
        return model.Cards
    }
    
    var endgame: Bool {
        return model.endgame
    }
    func getColor(card: SetLogic.SetCards) -> Color{
        switch card.Color {
        case "purple":
            return Color.purple
        case "green":
            return Color.green
        default:
            return Color.pink
        }
    }
    
    func getShapeName(card: SetLogic.SetCards) -> String{
        switch card.ShapeName {
        case .Diamond:
            return "Diamond"
        case .Swirly:
            return "Swirly"
        case .Oval:
            return "Oval"
        }
    }
    
    func getShading(card: SetLogic.SetCards) -> String{
        switch card.Shading{
        case .fill:
            return "fill"
        case .open:
            return "open"
        case .striped:
            return "striped"
        }
    }
    
    //MARK:: INTENT
    func add3cards() {
        model.addCards(3, at: nil)
    }
    
    func choose(_ card:SetLogic.SetCards){
        return model.choose(card: card)
    }
    
    func newGame() {
        model = SetGame.createModel()
    }
    
    func shuffle() {
        return model.shuffle()
    }
}

