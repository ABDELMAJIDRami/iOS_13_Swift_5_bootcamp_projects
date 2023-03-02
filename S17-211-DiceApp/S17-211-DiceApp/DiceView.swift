//
//  DiceView.swift
//  S17-211-DiceApp
//
//  Created by Rami ABDEL MAJID on 26/02/2023.
//

import SwiftUI

struct DiceView: View {
    let n: Int
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, // ratio of hight by width
                         contentMode: .fit)
            .padding()
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(n: 5).previewLayout(.sizeThatFits)
    }
}
