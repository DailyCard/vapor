//
//  Episode.swift
//  App
//
//  Created by roni on 2019/12/25.
//

import Foundation
import Vapor

struct Episode {
    var id: Int
    var desc: String
    init(id: Int, desc: String) {
        self.id = id
        self.desc = desc
    }

    init?(id: String) {
        if let eid = Int(id) {
            self.init(id: eid, desc: "Description of episode \(eid)")
        } else {
            return nil
        }
    }

}

extension Episode: Parameter {
    static func resolveParameter(_ parameter: String, on container: Container) throws -> Future<Episode?> {
        return Future.map(on: container, { () -> Episode? in
            let e = Episode(id: parameter)
            if e != nil { return e}
            throw Abort(HTTPResponseStatus.badRequest)
        })
    }
}

extension Episode: Content {
}
