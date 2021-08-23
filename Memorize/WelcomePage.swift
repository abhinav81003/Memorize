//
//  WelcomePage.swift
//  Memorize
//
//  Created by Abhinav Gupta on 08/06/21.
//

import SwiftUI

struct WelcomePage: View {
    var colors = [Color.blue,Color.gray,Color.red,Color.orange,Color.green,Color.yellow]
    var themenames = ["Animals", "Vehicles", "Flags", "Food", "Nature", "Tools"]
    var imagenames = ["hare.fill", "car.fill", "flag.fill","cart.fill","leaf.fill","wrench.and.screwdriver.fill"]
    var body: some View {
        VStack{
            NavigationView {
                VStack {
                    VStack(alignment: .leading){
                        Spacer(minLength: 0)
                        Text("Emoji Game").font(.largeTitle).padding(.leading).padding(.top)
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                            ForEach(0..<6){ index in
                                themeoptions(index: index, name: themenames[index], image: imagenames[index], color: colors[index])
                            }.aspectRatio(10/20, contentMode: .fill)
                        }
                        Text("Set Game").font(.largeTitle).padding(.leading).padding(.top)
                    }; VStack(alignment: .center) {
                        Spacer(minLength: 0)
                        NavigationLink(
                            destination: SetGameView(game: SetGame()),
                            label: {
                                HStack {
                                    Image(systemName: "plus").padding()
                                    Text("New Game").multilineTextAlignment(.center).foregroundColor(.black).font(.title).padding(10)
                                }.background(RoundedRectangle(cornerRadius: 7).fill(Color.yellow)).padding(20)
                            })
                    }
                }
            }
            
        }
        .padding(.bottom, 65.0)
    }
}

struct themeoptions : View {
    var index: Int
    var name: String
    var image: String
    var color: Color
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20).opacity(0)
            
                
            NavigationLink(destination: EmojiMemoryGameView(game: EmojiGame(ID: index))) {
                    VStack{
                        Image(systemName: image).resizable().frame(width: 80.0, height: 80.0).foregroundColor(color)
                        Text(name).foregroundColor(color)
                    }
                }.navigationTitle("Memory Games")
        }.padding(2)
    }
}










struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomePage()
                .preferredColorScheme(.light)
            WelcomePage()
                .preferredColorScheme(.light)
        }
        WelcomePage()
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/115.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
            .preferredColorScheme(.dark)
    }
}
