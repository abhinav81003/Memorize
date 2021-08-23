//
//  Diamond.swift
//  Set
//
//  Created by Abhinav Gupta on 22/06/21.
//

import SwiftUI

struct ShapeView: Shape {
    var shapeName: String
    var size: Int
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let height = (rect.height/CGFloat(2))*CGFloat(size)*0.3
        let width = (rect.width/2)*0.7
        let top = CGPoint(x: center.x, y: (center.y - height))
        let bottom = CGPoint(x: center.x, y: (center.y + height))
        let left = CGPoint(x: center.x - width, y: center.y)
        let farleft = CGPoint(x: left.x - height, y: left.y)
        let right = CGPoint(x: center.x + width, y: center.y)
        let topleft = CGPoint(x: left.x, y: left.y - height)
        let fartopleft = CGPoint(x: farleft.x, y: left.y - height)
        let bottomright = CGPoint(x: right.x, y: right.y + height)
        let farbottomright = CGPoint(x: right.x + height, y: right.y + height)
        let farbottomleft = CGPoint(x: farbottomright.x - 2*width - 2*height, y: right.y + height)
        let farright = CGPoint(x: right.x + height, y: right.y)
        let fartopright = CGPoint(x: farbottomright.x, y: farbottomright.y - 2*height)
        var p = Path()
        if shapeName == "Diamond"{
            p.move(to: top)
            p.addLine(to: farleft)
            p.addLine(to: bottom)
            p.addLine(to: farright)
            p.addLine(to: top)
        } else if shapeName == "Oval"{
            p.move(to: top)
            p.addLine(to: topleft)
            p.addArc(center: left,
                      radius: height,
                      startAngle: Angle(degrees: -90),
                      endAngle: Angle(degrees: 90),
                      clockwise: true)
            p.addLine(to: bottomright)
            p.addArc(center: right,
                      radius: height,
                      startAngle: Angle(degrees: 90),
                      endAngle: Angle(degrees: -90),
                      clockwise: true)
            p.addLine(to: top)
        } else if shapeName == "Swirly"{
            p.move(to: top)
            p.addLine(to: fartopleft)
            p.addLine(to: farbottomleft)
            p.addLine(to: farbottomright)
            p.addLine(to: fartopright)
            p.addLine(to: top)
        }
        return p
    }
}


