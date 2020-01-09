//
//  Home.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/12.
//  Copyright © 2019 Mars. All rights reserved.
//

import CoreData
import Foundation

public struct HomeData: Codable {
  public var type: Int = 1                             // 1 - browse; 2 - normal signing in; 3 - outdated signing in
  public var episodes: [Episode] = []
  public var recentUpdate: [RecentUpdate] = []
  public var watchingHistories: [WatchingHistory]?     // After signing in
  public var favouriteEpisodes: [FavouriteEpisode]?    // After signing in
  
  public var freeEpisodes: [FreeEpisode]?              // Browsing only
  public var watchLaterEpisodes: [WatchLaterEpisode]?  // After signing in
  
  public var learningPaths: [LearningPath] = []
  
  enum CodingKeys: String, CodingKey {
    case type
    case episodes
    case recentUpdate
    case watchingHistories
    case favouriteEpisodes
    case freeEpisodes
    case watchLaterEpisodes
    case learningPaths
  }
  
  public init(isSignedIn: Bool = false) {
    type = isSignedIn ? 2 : 1
    episodes = self.loadEpisodes()
    recentUpdate = self.loadRecentUpdates()
    learningPaths = self.loadLearningPath()
    
    if isSignedIn {
      watchingHistories = self.loadWatchingHistories()
      favouriteEpisodes = self.loadFavouriteEpisodes()
      freeEpisodes = nil
      watchLaterEpisodes = self.loadWatchLaterEpisodes()
    }
    else {
      watchingHistories = nil
      favouriteEpisodes = nil
      freeEpisodes = self.loadFreeEpisodes()
      watchLaterEpisodes = nil
    }
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decode(Int.self, forKey: .type)
    episodes = try container.decode([Episode].self, forKey: .episodes)
    recentUpdate = try container.decode([RecentUpdate].self, forKey: .recentUpdate)
    watchingHistories = try container.decodeIfPresent([WatchingHistory].self, forKey: .watchingHistories)
    favouriteEpisodes = try container.decodeIfPresent([FavouriteEpisode].self, forKey: .favouriteEpisodes)
    
    freeEpisodes = try container.decodeIfPresent([FreeEpisode].self, forKey: .freeEpisodes)
    watchLaterEpisodes = try container.decodeIfPresent([WatchLaterEpisode].self, forKey: .watchLaterEpisodes)
    
    learningPaths = try container.decode([LearningPath].self, forKey: .learningPaths)
    
    linkRecentUpdate()
    linkWatchingHistories()
    linkFavouriteEpisodes()
    linkFreeEpisodes()
    linkWatchLaterEpisodes()
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type, forKey: .type)
    try container.encode(episodes, forKey: .episodes)
    try container.encode(recentUpdate, forKey: .recentUpdate)
    try container.encodeIfPresent(watchLaterEpisodes, forKey: .watchLaterEpisodes)
    try container.encodeIfPresent(favouriteEpisodes, forKey: .favouriteEpisodes)
    
    try container.encodeIfPresent(freeEpisodes, forKey: .freeEpisodes)
    try container.encodeIfPresent(watchLaterEpisodes, forKey: .watchLaterEpisodes)
    
    try container.encode(learningPaths,forKey: .learningPaths)
  }
  
  private func linkRecentUpdate() {
    recentUpdate.forEach { updated in
      updated.episode = episodes.filter { updated.episodeId == $0.id }.first!
    }
  }
  
  private func linkWatchingHistories() {
    if watchingHistories != nil {
      watchingHistories!.forEach { history in
        history.episode = episodes.filter { history.episodeId == $0.id }.first!
      }
    }
  }
  
  private func linkFavouriteEpisodes() {
    if favouriteEpisodes != nil {
      favouriteEpisodes!.forEach { favourite in
        favourite.episode = episodes.filter { favourite.episodeId == $0.id }.first!
      }
    }
  }
  
  private func linkFreeEpisodes() {
    if freeEpisodes != nil {
      freeEpisodes!.forEach { free in
        free.episode = episodes.filter { free.episodeId == $0.id }.first!
      }
    }
  }
  
  private func linkWatchLaterEpisodes() {
    if watchLaterEpisodes != nil {
      watchLaterEpisodes!.forEach { watchLater in
        watchLater.episode = episodes.filter{ watchLater.episodeId == $0.id }.first!
      }
    }
  }
  
  private func loadEpisodes() -> [Episode] {
    return load()
  }
  
  private func loadRecentUpdates() -> [RecentUpdate] {
    return load()
  }
  
  private func loadFavouriteEpisodes() -> [FavouriteEpisode] {
    return load()
  }
  
  private func loadWatchLaterEpisodes() -> [WatchLaterEpisode] {
    return load()
  }
  
  private func loadFreeEpisodes() -> [FreeEpisode] {
    return load()
  }
  
  private func loadWatchingHistories() -> [WatchingHistory] {
    return load()
  }
  
  private func loadLearningPath() -> [LearningPath] {
    return load()
  }
  
  private func load<T>() -> [T] where T: NSManagedObject {
    let context = CoreDataManager.shared.managedContext
    /// Can not use `T.fetchRequest()` here. Either convert the `NSFetchRequest<NSFetchRequestResult>`
    /// to `NSFetchRequest<T>` explicitly or use the following `init`:
    let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
    
    do {
      return try context.fetch(fetchRequest)
    }
    catch {
      return []
    }
  }
}
