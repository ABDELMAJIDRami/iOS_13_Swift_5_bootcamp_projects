//
//  PostData.swift
//  S17-214-H4X0R News
//
//  Created by user183479 on 12/10/20.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String
}
