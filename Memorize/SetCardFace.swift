//
//  SetCardFace.swift
//  Memorize
//
//  Created by Abhinav Gupta on 01/07/21.
//

import SwiftUI

struct CardFace: AnimatableModifier {
    let shape  = RoundedRectangle(cornerRadius: 10)
    init (isFaceUp: Bool, failedMatch: Bool, isMatched: Bool) {
        self.failedMatch = failedMatch
        self.isMatched = isMatched
        self.rotation = isFaceUp ? 180 : 0
    }
    var failedMatch: Bool
    var isMatched: Bool
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var rotation: Double
    func body(content: Content) -> some View {
        ZStack{
            shape.fill(rotation > 90 ? Color.white : Color.yellow)
            shape.strokeBorder(lineWidth: 2.5).opacity(rotation > 90 ? 1 : 0)
            if rotation > 90 {
                shape.fill(Color.red).opacity(failedMatch ? 0.3 : 0)
                shape.fill(Color.green).opacity(isMatched ? 0.3 : 0)
            }
            content.opacity(rotation > 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation) ,axis: (x: 0, y: 1, z: 0))
    }
}

extension View {
    func Face(isFaceUp: Bool, failedMatch: Bool, isMatched: Bool) -> some View {
        return self.modifier(CardFace(isFaceUp: isFaceUp, failedMatch: failedMatch, isMatched: isMatched))
    }
}

