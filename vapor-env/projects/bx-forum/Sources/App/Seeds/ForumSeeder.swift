//
//  ForumSeeder.swift
//  App
//
//  Created by roni on 2020/1/6.
//

import Foundation
import Fluent
import FluentMySQL

struct ForumSeeder: Migration {
    typealias Database = MySQLDatabase

    static func prepare(on conn: MySQLConnection) -> EventLoopFuture<Void> {
        var createdForums = [Future<Forum>]()

        for i in 1...3 {
            let forum = Forum(id: i, name: "Forum \(i)").create(on: conn)
            createdForums.append(forum)
        }

        return createdForums.flatten(on: conn).transform(to: Void())

//        return [1, 2, 3]
//            .map{ i in
//                Forum(name: "Forum \(i)")
//            }
//            .map { $0.save(on: conn) }
//            .flatten(on: conn)
//            .transform(to: ())
    }

    static func revert(on conn: MySQLConnection) -> EventLoopFuture<Void> {
        // 这里我们为了简单起见直接使用 query 方法执行了一条 SQL 语句把 Forum 表清空就好了
        return conn.query("truncate table `Forum`").transform(to: Void())
    }
}
