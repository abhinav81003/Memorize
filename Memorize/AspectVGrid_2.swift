//
//  AspectVGrid.swift
//  Set
//
//  Created by Abhinav Gupta on 25/06/21.
//

import SwiftUI

struct AspectVGrid_2<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    var items: Array<Item>
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var body: some View {
            VStack {
                GeometryReader { geometry in
                    let width = getWidth(items.count, geometry.size.width, geometry.size.height, aspectRatio)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum:width))]){
                        ForEach(items){item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                }
            Spacer(minLength: 0)
            }
    }
}

func getWidth (_ numberOfCards: Int, _ totalWidth: CGFloat, _ totalHeight: CGFloat, _ aspectRatio: CGFloat) -> CGFloat{
    var numberOfColumns = 1
    var numberOfRows = numberOfCards
    repeat {
        let itemWidth = totalWidth/CGFloat(numberOfColumns)
        let itemHeight = itemWidth/aspectRatio
        numberOfColumns += 1
        if CGFloat(numberOfRows) * itemHeight < totalHeight{
            break
        }
        numberOfRows = (numberOfCards+numberOfColumns-1)/numberOfColumns
    } while (numberOfColumns < numberOfCards)
    if numberOfColumns > numberOfCards{
        numberOfColumns = numberOfCards
    }
    return floor(totalWidth/CGFloat(numberOfColumns))
}
