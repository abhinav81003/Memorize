import SwiftUI



class EmojiGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card
    
    @Published var model: MemoryGame<String>
    
    static func createMemoryGame (theme: Theme) -> MemoryGame<String>{
        var pairs = 6
        if pairs > theme.content.count{
            pairs = theme.content.count
        }
        return MemoryGame<String>(numberOfPairsOfCards: pairs){
            return  theme.content.shuffled()
        }
    }
    
    var score: Int{
        return model.score
    }
    var cards: Array<Card>{
        return model.cards
    }
    
    var end: Bool{
        return model.end
    }
    
    init(ID: Int?){
        if ID == nil{
            initialtheme = EmojiGame.themeslist.randomElement()!
        }else{
            initialtheme = EmojiGame.themeslist[ID!]
        }
        ThemeModel = EmojiGame.createrandomTheme(currenttheme: initialtheme)
        model = EmojiGame.createMemoryGame(theme: initialtheme)
    }
    
    typealias Theme = GameThemes.Theme
    
    @Published var ThemeModel: GameThemes
    
    static var themeslist: Array<Theme> = [Theme(themeName: "Animals", numberOfCards: 6, cardColor: "blue", content : ["🐟","🦊","🦁","🦥","🐥","🐵","🐙","🐷","🐼","🐶","🦧","🐻","🐸","🐨","🐮","🐯","🦍","🐿","🦖","🐱","🐹","🐀","🦔","🐭","🐔","🐧","🐦","🦆","🦄","🐴","🐡","🐊","🦈","🐳","🦍","🐆","🐫","🦓","🦒","🦘","🐐","🐩","🐃","🐁","🦩","🦦","🦨","🐉","🐘","🦛","🦏","🐪","🦢","🦜","🐠","🦑","🦞","🦐","🦕","🕷","🐅","🦎","🐢"]), Theme(themeName: "Vehicles", numberOfCards: 6, cardColor: "gray", content : ["🚘","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🚚","🚛","🚜","🦽","🦼","🛴","🚲","🛵","🏍","🛺","🚔","🚍","🚗","🚖","🚡","🚠","🚟","🚃","🚋","🚞","🚝","🚄","🚅","🚈","🚂","🚆","🚇","🚊","🚉","✈️","🛫","🛩","🛰","🚀","🛸","🚁","🛶","⛵️","🚤","🛥","🛳","⛴","🚢","🎡"]), Theme(themeName: "Flags", numberOfCards: 6, cardColor: "red", content : ["🇦🇫","🇦🇽","🇦🇱","🇩🇿","🇦🇸","🇦🇩","🇦🇴","🇦🇮","🇦🇶","🇦🇬","🇦🇷","🇦🇲","🇦🇼","🇦🇺","🇦🇹","🇦🇿","🇿🇲","🇧🇭","🇧🇩","🇧🇧","🇧🇾","🇧🇪","🇧🇿","🇧🇲","🇧🇯","🇧🇹","🇧🇴","🇧🇦","🇧🇼","🇧🇷","🇮🇴","🇻🇬","🇧🇳","🇧🇬","🇧🇫","🇧🇮","🇰🇭","🇨🇲","🇨🇦","🇮🇨","🇨🇻","🇧🇶","🇰🇾","🇨🇫","🇹🇩","🇨🇱","🇨🇳","🇨🇽","🇨🇨","🇨🇴","🇰🇲","🇨🇬","🇨🇩","🇨🇰","🇨🇷","🇭🇷","🇨🇮","🇨🇺","🇨🇼","🇨🇾","🇨🇿","🇩🇰","🇩🇯","🇩🇲","🇩🇴","🇪🇨","🇪🇬","🇸🇻","🇬🇶","🇪🇷","🇪🇪","🇸🇿","🇪🇹","🇪🇺","🇫🇰","🇫🇴","🇫🇯","🇫🇮","🇫🇷","🇬🇫","🇵🇫","🇹🇫","🇬🇦","🇬🇲","🇬🇪","🇩🇪","🇬🇭","🇬🇮","🇬🇷","🇬🇱","🇬🇩","🇬🇵","🇬🇺","🇬🇹","🇬🇬","🇬🇳","🇬🇼","🇬🇾","🇭🇹","🇭🇳","🇭🇰","🇭🇺","🇮🇸","🇮🇳","🇮🇩","🇮🇷","🇮🇶","🇮🇪","🇮🇲","🇮🇱","🇮🇹","🇯🇲","🇯🇵","🇯🇪","🇯🇴","🇰🇿","🇰🇪","🇰🇮","🇽🇰","🇰🇼","🇰🇬","🇱🇦","🇱🇻","🇱🇸","🇱🇾","🇲🇹","🇲🇭","🇲🇶","🇲🇷","🇲🇺","🇾🇹","🇲🇸","🇵🇰","🇬🇸","🇿🇦","🇹🇴","🇬🇧","🇦🇪","🇿🇼","🇪🇭","🇾🇪","🇰🇷","🇸🇴"]),Theme(themeName: "Food", numberOfCards: 6, cardColor: "orange", content : ["🍎","🥞","🍔","🍟","🍖","🍦","🥗","🌮","🥪","🧀","🍗","🌭","🥮","🥩","🍕","🌯","🍚","🥘","🧇","🧆","☕️","🍝","🍜","🍲","🍱","🥟","🍏","🍋","🍉","🍊","🥯","🥐","🍠","🥨","🥫","🧁","🥧","🍧","🍨","🍤","🍅","🍌","🥑","🧈","🍞","🥠","🍥","🍘","🍙","🍫","🥜","🧉","🥡","🥣","🧃","🍵","🍪","🍩","🍬","🍭","🌰","🍯","🥛","🥂","🍺","🍷","🍽","🍢","🍣","🥔","🥝","🥥","🥭","🍒","🧄","🥚","🍶","🍮","🎂"]), Theme(themeName: "Nature", numberOfCards: 6, cardColor: "green" , content : ["🍂","☀️","⛅️","🌨","🌚","🌴","🌲","💐","🌻","🌺","🌹","🌵","☘️","🥀","🌼","🌷","🎋","🌊","🌽","🥕","🥬","🍇","🍁","✿","❁","❃","🌳","🎍","🍃","🌿","🍀","🍄","🐚","🌾","🎄","⛄️","🌫","🕊"]), Theme(themeName: "Tools", numberOfCards: 6, cardColor: "yellow", content : ["🔧","🛠","⛓","🧲","🪓","🧹","🧻","🔑","🔪","🛎","💈","🔨","🕹","⚙️","⚔️","🧰","🔌","🔦","💡","🕰","⏳","⚖️","🏺","🔫","🧭","☎️","📀","🔭","🧨","🔩","🧯","📟","📠","🎥","🗜","🖲","⚒","⛏","🧱","⚱️","🏺","📿","🧿","🧺","🗝","🪒","🛒","📮","✂️","🖊","✏️","🖍","🔓","🔒","📍","🧮","📏","🧷","🏮","🩹","🎛","⌛️","🎚","⏲","🗞","🔐","🖌","🔮"])]
    
    
    static func createrandomTheme(currenttheme: Theme) -> GameThemes{
        return GameThemes(allthemes: themeslist, currenttheme: currenttheme)
    }
    
    var initialtheme: Theme
    
    var actualtheme: Theme {
        return ThemeModel.currenttheme!
    }
    var cardColor: Color{
        switch actualtheme.cardColor{
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "gray":
            return Color.gray
        case "yellow":
            return Color.yellow
        case "green":
            return Color.green
        case "orange":
            return Color.orange
        default:
            return Color.red
        }
    }
    

    //MARK: - Intents

    func choose(_ card: Card){
        model.choose(card)
    }
    
    func new(){
        model = EmojiGame.createMemoryGame(theme: actualtheme)
    }
    
    func shuffle() {
        return model.shuffle()
    }
}
    
