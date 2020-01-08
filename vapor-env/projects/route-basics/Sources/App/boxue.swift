//
//  boxue.swift
//  App
//
//  Created by roni on 2019/12/30.
//

import Foundation
import Vapor


final class BoxueRouteCollection: RouteCollection {
    func boot(router: Router) throws {
        let boxue = router.grouped("episode", Int.parameter)

        boxue.get("play") {
            req -> HTTPStatus in
            let id = try req.parameters.next(Int.self)
            print("play episode \(id)")

            return HTTPStatus.noContent
        }

        boxue.post("finish") {
            req -> HTTPStatus in
            let id = try req.parameters.next(Int.self)
            print("finish episode \(id)")

            return HTTPStatus.noContent
        }
    }
}
