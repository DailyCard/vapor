//
//  user.swift
//  Future
//
//  Created by roni on 2019/12/30.
//  Copyright © 2019 roni. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: UInt
    var email: String
}

typealias Completion = (Result<[User]>) -> Void

func load(_ completion: @escaping Completion) {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error {
            completion(.error(error))
        }
        else {
            do {
                let users = try JSONDecoder().decode([User].self, from: data!)
                completion(.value(users))
            }
            catch {
                completion(.error(error))
            }
        }
    }
    task.resume()
}

//func load() -> Future<Data> {
//    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
//    return URLSession.shared.request(url: url)
//}

func load() -> Future<[User]> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    return URLSession.shared.request(url: url).map({ (data) in
        try! JSONDecoder().decode([User].self, from: data)
    })
}
