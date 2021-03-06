//
//  MessageSeeder.swift
//  App
//
//  Created by roni on 2020/1/8.
//

import Foundation
import Vapor
import Fluent
import FluentMySQL

struct MessageSeeder: Migration {
    typealias Database = MySQLDatabase

    static func prepare(on conn: MySQLConnection) -> EventLoopFuture<Void> {
        var messageId = 0
        return [1, 2, 3].flatMap {
            forum in
            return [1, 2, 3, 4, 5].map {
                message -> Message in
                messageId += 1
                let title = "Title \(message) in Forum \(forum)"
                let content = "Body of Title \(message)"
                let originId = message > 3 ? (forum * 5 - 4) : 0
                return Message(
                    id: messageId,
                    forumId: forum,
                    title: title,
                    content: content,
                    originId: originId,
                    author: "roni",
                    createdAt: Date())
            }
            }
            .map { $0.create(on: conn) }
            .flatten(on: conn)
            .transform(to: ())
    }

    static func revert(on conn: MySQLConnection) -> EventLoopFuture<Void> {
        return conn.query("truncate table `Message`")
            .transform(to: Void())
    }
}
