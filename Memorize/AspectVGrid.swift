//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Abhinav Gupta on 14/06/21.
//

import SwiftUI


@ViewBuilder func AspectVGrid<Item, ItemView>(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView ) -> some View where ItemView: View , Item: Identifiable {
        GeometryReader { geometry in
            VStack{
                let width: CGFloat = bestwidth(itemCount: items.count, in:  geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items){ item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
}

private func adaptiveGridItem(width: CGFloat) -> GridItem{
    var gridItem = GridItem(.adaptive(minimum: width))
    gridItem.spacing = 0
    return gridItem
}

private func bestwidth(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat{
    var columnCount = 1
    var rowCount = itemCount
    repeat {
        let itemWidth = size.width / CGFloat(columnCount)
        let itemHeight = itemWidth / itemAspectRatio
        if CGFloat(rowCount) * itemHeight < size.height{
            break
        }
        columnCount += 1
        rowCount = (itemCount+(columnCount-1))/columnCount
    }while columnCount < itemCount
    if columnCount > itemCount{
        columnCount = itemCount
    }
    return floor(size.width / CGFloat(columnCount))
}


//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}


