//
//  ContentView.swift
//  S17-I Am Rich
//
//  Created by user183479 on 12/9/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemTeal).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Hello, world!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0, alignment: Alignment.center)
            
            }
            // we don't want to add an image insde a ZStack bcz it will appear on top of the Z-axis
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // ContentView()
            //.previewDevice(/*@START_MENU_TOKEN@*/"iPhone 8"/*@END_MENU_TOKEN@*/)
        ContentView()
    }
}
