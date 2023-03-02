//
//  ContentView.swift
//  S17-208-RamiCard
//
//  Created by user183479 on 12/9/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
//            Color(red: 0.09, green: 0.63, blue: 0.52, opacity: 0.5)   // opacity is optional. in UIKit it was called alpha
                
            Color(red: 0.09, green: 0.63, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            VStack() {
//                HStack {
//                    HStack {
                        
                        Image("Rami")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200.0, height: 200.0)
    //                        .clipShape(RoundedRectangle(cornerRadius: 50))
    //                        .clipShape(Rectangle())
                            // u can use any shape from the views/components sections
                            .clipShape(Circle())
                            .overlay(   // overlay a component above a component
                                // Circle()    // filled by default
                                Circle().stroke(Color.white, lineWidth: 5), alignment: .bottom
                            )
                    
//                }
                Text("Rami Abdel Majid")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "+96170731714", imageName: "phone.fill")
                InfoView(text: "rami@outlook.com", imageName: "envelope.fill")
            }
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

