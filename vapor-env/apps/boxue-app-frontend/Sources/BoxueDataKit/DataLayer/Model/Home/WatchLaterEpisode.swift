//
//  FavouriteEpisode.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/10/10.
//  Copyright © 2019 Mars. All rights reserved.
//

import CoreData
import Foundation

@objc(WatchLaterEpisode)
public class WatchLaterEpisode: NSManagedObject, Codable {
  // Attributes
  @NSManaged public var episodeId: Int
  
  // Relationship
  @NSManaged public var episode: Episode
  
  enum CodingKeys: String, CodingKey {
    case episodeId
  }
  
  public required convenience init(from decoder: Decoder) throws {
    /// `userInfo[codingUserInfoKeyManagedObjectContext]` was initialized
    /// before creating the `decoder` and injecting it into the `init`.
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
      let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "WatchLaterEpisode", in: managedObjectContext) else {
      fatalError("Failed to decode watch later episode.")
    }
    
    self.init(entity: entity, insertInto: managedObjectContext)
    
    CoreDataManager.shared.clearStorage(entityName: "WatchLaterEpisode")
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    episodeId = try container.decode(Int.self, forKey: .episodeId)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(episodeId, forKey: .episodeId)  }
}

extension WatchLaterEpisode {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchLaterEpisode> {
    return NSFetchRequest<WatchLaterEpisode>(entityName: "WatchLaterEpisode")
  }
}
