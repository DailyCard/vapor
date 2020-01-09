//
//  LearningPath.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/12.
//  Copyright © 2019 Mars. All rights reserved.
//
import CoreData
import Foundation

@objc(WatchingHistory)
public class WatchingHistory: NSManagedObject, Codable {
  // Attributes
  @NSManaged public var episodeId: Int
  @NSManaged public var progress: Int
  @NSManaged public var updatedAt: Date
  
  // Relationship
  @NSManaged public var episode: Episode
  
  public var progressText: String {
    let min: Int = progress / 60
    let sec: Int = progress % 60
    return String(format: "%02d:%02d", min, sec)
  }
  
  enum CodingKeys: String, CodingKey {
    case episodeId
    case progress
    case updatedAt
  }
  
  public required convenience init(from decoder: Decoder) throws {
    /// `userInfo[codingUserInfoKeyManagedObjectContext]` was initialized
    /// before creating the `decoder` and injecting it into the `init`.
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
      let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "WatchingHistory", in: managedObjectContext) else {
      fatalError("Failed to decode free episodes.")
    }
    
    self.init(entity: entity, insertInto: managedObjectContext)
    
    CoreDataManager.shared.clearStorage(entityName: "WatchingHistory")
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    episodeId = try container.decode(Int.self, forKey: .episodeId)
    progress = try container.decode(Int.self, forKey: .progress)
    
    let datetime = try container.decode(String.self, forKey: .updatedAt)
    guard let date = DateFormatter.mysql.date(from: datetime) else {
      throw DataKitError.dataCorrupt
    }
    updatedAt = date
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(episodeId, forKey: .episodeId)
    try container.encode(progress, forKey: .progress)
    
    let datetime = DateFormatter.mysql.string(from: updatedAt)
    try container.encode(datetime, forKey: .updatedAt)
  }
}

extension WatchingHistory {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchingHistory> {
    return NSFetchRequest<WatchingHistory>(entityName: "WatchingHistory")
  }
}

