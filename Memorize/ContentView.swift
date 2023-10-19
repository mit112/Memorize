//
//  ContentView.swift
//  Memorize
//
//  Created by Mit Sheth on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🤭","🤭","🤭","🤭","🤭","🤭","🤭","🤭","🤭","🤭"]
    @State var cardCount = 2
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cardCountAdjusters: some View{
        VStack{
            HStack{
                cardRemover
                Spacer()
                cardAdder
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], content: {
            ForEach(0..<cardCount, id: \.self){ index in
                cardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundStyle(Color(.orange))
        })
    }
    func cardCountAdjuster (by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        },
               label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
    }
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus")
    }
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
