//
//  Cardify.swift
//  Memorize
//
//  Created by Abhinav Gupta on 28/06/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    init (isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
     
    var animatableData: Double{
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation : Double // in degrees
    
    func body(content: Content) -> some View {
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if  rotation < 90 {
                    shape.fill(Color.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                }else {
                    shape.fill()
                }
                content.opacity(rotation < 90 ? 1 : 0)
            }
            .rotation3DEffect(
                Angle.degrees(rotation),
                axis: (0,1,0)
            )
        }
    }
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

struct Dissapear: ViewModifier {
    var isMatched: Bool
    func body(content: Content) -> some View {
        ZStack{
            if isMatched{
                Color.clear
            } else {
                content
            }
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    func dissappear(isMatched: Bool) -> some View {
        return self.modifier(Dissapear(isMatched: isMatched))
    }
}
