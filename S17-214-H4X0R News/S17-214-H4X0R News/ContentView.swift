//
//  ContentView.swift
//  S17-214-H4X0R News
//
//  Created by user183479 on 12/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {    // navigation stack - header
//            List {
//                Text("Hello, world!")
//                Text("Hello, world!")
//            }
            List(posts) { post in
                Text(post.title)
            }
            // currently we can't change navigation bar background color
            .navigationBarTitle("H4X0R News")
        }
        // .navigationBarTitle("Test") for a reason we are putting this prop inside NaigationView for it to work
        
    }
}

let posts: [Post] = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjour"),
//    Post(id: "3", title: "Hola")
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
