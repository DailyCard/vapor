//
//  LearningPath.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/12.
//  Copyright © 2019 Mars. All rights reserved.
//
import CoreData
import Foundation

@objc(LearningPath)
public class LearningPath: NSManagedObject, Codable {
  @NSManaged public var title: String
  @NSManaged public var coverUrl: String
  @NSManaged public var summary: String
  @NSManaged public var totalEpisodes: Int
  @NSManaged public var totalDuration: Int
  
  enum CodingKeys: String, CodingKey {
    case title
    case coverUrl
    case summary
    case totalEpisodes
    case totalDuration
  }
  
  public required convenience init(from decoder: Decoder) throws {
    /// `userInfo[codingUserInfoKeyManagedObjectContext]` was initialized
    /// before creating the `decoder` and injecting it into the `init`.
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
      let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "LearningPath", in: managedObjectContext) else {
      fatalError("Failed to decode learning path")
    }
    
    self.init(entity: entity, insertInto: managedObjectContext)
    
    CoreDataManager.shared.clearStorage(entityName: "LearningPath")
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    coverUrl = try container.decode(String.self, forKey: .coverUrl)
    summary = try container.decode(String.self, forKey: .summary)
    totalEpisodes = try container.decode(Int.self, forKey: .totalEpisodes)
    totalDuration = try container.decode(Int.self, forKey: .totalDuration)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(title, forKey: .title)
    try container.encode(coverUrl, forKey: .coverUrl)
    try container.encode(summary, forKey: .summary)
    try container.encode(totalEpisodes, forKey: .totalEpisodes)
    try container.encode(totalDuration, forKey: .totalDuration)
  }
}

extension LearningPath {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningPath> {
    return NSFetchRequest<LearningPath>(entityName: "LearningPath")
  }
}
