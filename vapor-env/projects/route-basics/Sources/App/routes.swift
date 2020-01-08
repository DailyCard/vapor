import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
//    router.get("episode") { req -> String in
//        return "Router basics ..."
//    }

    router.get("episode", "route-basics") { (req) -> String in
        return "The route-basics description"
    }

    router.get("episode", Episode.parameter) { (req) -> Future<Episode> in
        let episode = try req.parameters.next(Episode.self)
//        return "Episode id:  \(episode.id)\nEpisode desc: \(episode.desc)"
        return episode.map(to: Episode.self, { (episode) -> Episode in
            guard let episode = episode else {
                throw Abort(.badRequest)
            }
            return episode
        })
    }

    router.get("series", String.parameter, Int.parameter) { (req) -> String in
        let seriesName = try req.parameters.next(String.self)
        let episodeId = try req.parameters.next(Int.self)
        return "Infomation of series: \(seriesName) - episode \(episodeId)"
    }

    router.post("episode") { req in
        return getEpisode(from: req).flatMap(to: Response.self, { episode in
            return save(episode, for: req)
        }).transform(to: HTTPStatus.noContent)
    }

    router.post("episodes") { req -> Future<HTTPStatus> in
        let episodes = [
            Episode(id: 1, desc: "Just for demo1"),
            Episode(id: 2, desc: "Just for demo2"),
            Episode(id: 3, desc: "Just for demo3")
        ]

        var saved = [Future<Response>]()
        episodes.forEach({
            saved.append(save($0, for: req))
        })

        return saved.flatten(on: req).transform(to: HTTPStatus.created)
    }

//    router.post("upload") { (req) -> Future<Response> in
//        let hardCoded = getEpisode(from: req)
//        let decoded = try req.content.decode(Episode.self)
//        return flatMap(to: Response.self, hardCoded, decoded, { (ep1, ep2) in
//            return req.future([ep1, ep2]).encode(status: .created, for: x)
//        })
//    }

    router.post("upload") { (req) -> Future<Response> in
        let hardCoded = getEpisode(from: req)
        let decoded = try req.content.decode(Episode.self)
        return flatMap(to: [Episode].self, hardCoded, decoded, { (ep1, ep2) in
            return req.future([ep1, ep2])
        }).encode(status: .created, for: req)
    }

    router.get("error", Episode.parameter) { (req) -> Future<Episode> in
        return try req.parameters.next(Episode.self)
            .map {
                return $0!
            }
            .catchMap({ (error) -> (Episode) in
                print("Exception: \(error)")
                return Episode(id: 0, desc: "Unknown")
            })
            .always {
                print("Episode returned")
        }
//            .catch { error in
//                print("Exception: \(error)")
//        }
    }

    router.group("v1") { group in
        group.get("episode", use: { (req) -> String in
            return "+==="
        })

        group.get("users", use: { (req) -> String in
            return "-----"
        })
    }


//    router.group("v1") { group in
//        group.group("episode", Int.parameter) { subgroup in
//            subgroup.post("play", use: { (req) -> String in
//                let id = try req.parameters.next(Int.self)
//                return "Play \(id)"
//            })
//
//            subgroup.post("finish") { req -> String in
//                let id = try req.parameters.next(Int.self)
//                return "Finish \(id)"
//            }
//        }
//    }


    router.group("v1") { group in
        let subgroup = group.grouped("episode", Int.parameter)
        subgroup.post("play", use: { (req) -> String in
            let id = try req.parameters.next(Int.self)
            return "Play \(id)"
        })

        subgroup.post("finish") { req -> String in
            let id = try req.parameters.next(Int.self)
            return "Finish \(id)"
        }
    }

    try router.register(collection: BoxueRouteCollection())

}

func getEpisode(from req: Request) -> Future<Episode> {
    return req.future(
        Episode(id: 1, desc: "Jush for demo")
    )
}

func save(_ episode: Episode, for req: Request) -> Future<Response> {
    return episode.encode(status: .created, for: req)
}
