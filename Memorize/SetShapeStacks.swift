//
//  SetShapeStacks.swift
//  Memorize
//
//  Created by Abhinav Gupta on 01/07/21.
//

import SwiftUI


struct twoShapeStack: View {
    let game: SetGame
    let card: SetLogic.SetCards
    var body: some View {
        VStack{
            switch (game.getShading(card:card)){
            case "open":
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).stroke(lineWidth: 2)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).stroke(lineWidth: 2)
            case "striped":
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).opacity(0.5)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).opacity(0.5)
            default:
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes)
            }
        }.foregroundColor(game.getColor(card:card))
    }
}
struct threeShapeStack: View {
    let game: SetGame
    let card: SetLogic.SetCards
    var body: some View {
        VStack{
            switch (game.getShading(card:card)){
            case "open":
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).stroke(lineWidth: 2)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).stroke(lineWidth: 2)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).stroke(lineWidth: 2)
            case "striped":
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).opacity(0.5)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).opacity(0.5)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).opacity(0.5)
            default:
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes)
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes)
            }
        }.foregroundColor(game.getColor(card:card))
    }
}
struct oneShapeStack: View {
    let game: SetGame
    let card: SetLogic.SetCards
    var body: some View {
        VStack{
            switch (game.getShading(card:card)){
            case "open":
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).stroke(lineWidth: 2)
            case "striped":
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes).opacity(0.5)
            default:
                ShapeView(shapeName: game.getShapeName(card: card), size: card.NumberOfShapes)
            }
        }.foregroundColor(game.getColor(card:card))
    }
}
