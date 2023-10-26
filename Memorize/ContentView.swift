//
//  ContentView.swift
//  Memorize
//
//  Created by Mit Sheth on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = ["🚅","🚕","🚙","🚌","🚙","🚌","🚕","🚅"]
    let vehicles: [String] = ["🚅","🚕","🚙","🚌","🚙","🚌","🚕","🚅"]
    let holloween: [String] = ["🎃","🕸️","👻","👹","👹","👻","🕸️","🎃"]
    let fruits: [String] = ["🍎","🍇","🍌","🍓","🍓","🍌","🍇","🍎"]
    @State var cardCount = 8
    var body: some View {
        VStack{
            Text("Memorize!")
            .font(.largeTitle)
            ScrollView{
                cards
            }
            Spacer()
            themeChanger
//            cardCountAdjusters
        }
        .padding()
    }
    var themeChanger: some View{
        HStack{
            vehicleThemeButton
            Spacer()
            holloweenThemeButton
            Spacer()
            fruitThemeButton
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    
    func themeButton (by offset: [String], symbol: String, offset2: String) -> some View{
        VStack{
            Button(action: {
                emojis = offset
            }, label: {
                Image(systemName: symbol)
            })
            Text(offset2)
                .font(.caption)
        }
    }
    var vehicleThemeButton: some View {
        themeButton(by: vehicles, symbol: "car", offset2: "Vehicles")
    }
    var holloweenThemeButton: some View {
        themeButton(by: holloween, symbol: "cloud.moon.bolt.fill", offset2: "Holloween")
    }
    var fruitThemeButton: some View {
        themeButton(by: fruits, symbol: "apple.logo", offset2: "Fruits")
    }
    
//    var cardCountAdjusters: some View{
//        VStack{
//            HStack{
//                cardRemover
//                Spacer()
//                cardAdder
//            }
//            .imageScale(.large)
//            .font(.largeTitle)
//        }
//    }
    var cards: some View {
        let shuffledEmojis = emojis.shuffled();
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
            ForEach(0..<cardCount, id: \.self){ index in
                cardView(content: shuffledEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .font(.largeTitle)
            }
            .foregroundStyle(Color(.orange))
        })
    }
//    func cardCountAdjuster (by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//        },
//               label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
//    }
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus")
//    }
}
struct cardView: View {
    let content: String
    @State var isFaceUp = true
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 20.0)
        ZStack(content: {
            Group{
                base.foregroundStyle(Color(.white))
                base.strokeBorder(style: StrokeStyle(lineWidth: 2.0))
                Text(content)
            }
            .opacity(isFaceUp ? 1 : 0)
             base.opacity(isFaceUp ? 0 : 1)
            
        })
        .onTapGesture(){
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
