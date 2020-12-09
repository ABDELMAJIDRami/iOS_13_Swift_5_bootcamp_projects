//
//  InfoView.swift
//  S17-208-RamiCard
//
//  Created by user183479 on 12/9/20.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)  // by default it stretch to takeall available space
            .fill(Color.white)
            .frame(height: 50.0)   // by default the width/height will extend to the max available space if not defined
            //                    .foregroundColor(.white)    // for shapes its better to use fill rather than foreground
            // .fill(Color.green)  // using fill() after frame() was throwing error (not detected as a prop)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                    Text(text)
                })
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Flame", imageName: "flame.fill")
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
