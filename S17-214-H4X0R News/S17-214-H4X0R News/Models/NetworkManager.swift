//
//  NetworkManager.swift
//  S17-214-H4X0R News
//
//  Created by user183479 on 12/10/20.
//

import Foundation

struct NetworkManager {
    func fetchData() {
        if let url = URL(string: "") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {    // data is optional
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
