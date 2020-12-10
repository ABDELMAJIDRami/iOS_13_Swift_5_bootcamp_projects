//
//  ContentView.swift
//  S17-211-DiceApp
//
//  Created by user183479 on 12/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("diceeLogo")
                Spacer() // A flexible space that expands along the major axis of its containing stack layout, or on both axes if not contained in a stack.
                HStack {
                    DiceeView(n: 2)
                    DiceeView(n: 5)
                }
                // .padding()  // around all corners
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    // action param take a closure
                }) {
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DiceeView: View {
    let n: Int
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, // ratio of hight by width
                         contentMode: .fit)
            .padding()
    }
}
