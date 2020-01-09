//
//  Episode.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/12.
//  Copyright © 2019 Mars. All rights reserved.
//
import CoreData
import Foundation

@objc(Episode)
public class Episode: NSManagedObject, Codable {
  // Attributes
  @NSManaged public var id: Int
  @NSManaged public var title: String
  @NSManaged public var coverUrl: String
  @NSManaged public var duration: Int
  @NSManaged public var tagString: String
  @NSManaged public var type: Int
  @NSManaged public var level: Int
  @NSManaged public var summary: String
  @NSManaged public var updatedAt: Date
  
  // Relationships
  @NSManaged public var favourite: FavouriteEpisode?
  @NSManaged public var freeEpisode: FreeEpisode?
  @NSManaged public var history: WatchingHistory?
  @NSManaged public var recentUpdate: RecentUpdate?
  @NSManaged public var watchLater: WatchLaterEpisode?
  
  public var tags: [String] {
    return tagString.components(separatedBy: ",")
  }
  
  public var updatedAtStr: String {
    let formatter = DateFormatter.normal
    let datetime = formatter.string(from: updatedAt)
    
    return datetime
  }
  
  public var levelText: String {
    switch level {
    case 1:
      return "#beginner"
    case 2:
      return "#intermediate"
    case 3:
      return "#advanced"
    default:
      return "#unknown"
    }
  }
  
  public var typeText: String {
    switch type {
    case 1:
      return "Free"
    default:
      return ""
    }
  }
  
  public var durationText: String {
    let min: Int = duration / 60
    let sec: Int = duration % 60
    return String(format: "%02d:%02d", min, sec)
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case coverUrl
    case duration
    case tagString
    case type
    case level
    case summary
    case updatedAt
  }
  
  public required convenience init(from decoder: Decoder) throws {
    /// `userInfo[codingUserInfoKeyManagedObjectContext]` was initialized
    /// before creating the `decoder` and injecting it into the `init`.
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
      let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "Episode", in: managedObjectContext) else {
      fatalError("Failed to decode episodes.")
    }
    
    self.init(entity: entity, insertInto: managedObjectContext)
    
    CoreDataManager.shared.clearStorage(entityName: "Episode")
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    coverUrl = try container.decode(String.self, forKey: .coverUrl)
    duration = try container.decode(Int.self, forKey: .duration)
    tagString = try container.decode(String.self, forKey: .tagString)
    level = try container.decode(Int.self, forKey: .level)
    type = try container.decode(Int.self, forKey: .type)
    summary = try container.decode(String.self, forKey: .summary)
    
    let datetime = try container.decodeIfPresent(String.self, forKey: .updatedAt)
    guard let dt = datetime, let date = DateFormatter.mysql.date(from: dt) else {
      throw DataKitError.dataCorrupt
    }
    updatedAt = date
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(title, forKey: .title)
    try container.encode(coverUrl, forKey: .coverUrl)
    try container.encode(duration, forKey: .duration)
    try container.encode(tagString, forKey: .tagString)
    try container.encode(type, forKey: .type)
    try container.encode(level, forKey: .level)
    
    let datetime = DateFormatter.mysql.string(from: updatedAt)
    try container.encode(datetime, forKey: .updatedAt)
  }
}

extension Episode {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Episode> {
    return NSFetchRequest<Episode>(entityName: "Episode")
  }
}
