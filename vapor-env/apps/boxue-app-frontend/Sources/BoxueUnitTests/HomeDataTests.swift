//
//  HomeDataTests.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/10/11.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest
import CoreData

@testable import Boxue_iOS
@testable import BoxueDataKit

class HomeDataTests: XCTestCase {
  override func setUp() {
    /// Clear old records before each test.
    /// We put these methods in `setUp`, not `tearDown`,
    /// for the sake of checking the SQLite DB after testing.
    CoreDataManager.shared.clearStorage(entityName: "Episode")
    CoreDataManager.shared.clearStorage(entityName: "FreeEpisode")
    CoreDataManager.shared.clearStorage(entityName: "RecentUpdate")
    CoreDataManager.shared.clearStorage(entityName: "LearningPath")
  }

  override func tearDown() {}
  
  func testEpisodeStorage() {
    let homeData = makeHomeDataForUnsigned()
    
    let decoder = JSONDecoder()
    let managedObjectContext = CoreDataManager.shared.managedContext
    decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = managedObjectContext
    
    do {
      // 1. Save data into core data
      _ = try decoder.decode(HomeData.self, from: homeData)
      CoreDataManager.shared.saveContext()
      
      // 2. Load data from core data
      let episodeFR: NSFetchRequest<Episode> = Episode.fetchRequest()
      
      // 3. Test cases
      episodeFR.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Episode.id), 1])
      let episode = try CoreDataManager.shared.managedContext.fetch(episodeFR).first
      
      XCTAssertNotNil(episode)
      XCTAssertEqual(episode!.recentUpdate!.episodeId, 1) // Test relationship
      
      let recentUpdateFR: NSFetchRequest<RecentUpdate> = RecentUpdate.fetchRequest()
      recentUpdateFR.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(RecentUpdate.episodeId), 1])
      let update = try CoreDataManager.shared.managedContext.fetch(recentUpdateFR).first
      
      XCTAssertNotNil(update)
      XCTAssertEqual(update!.episode.title, "title1") // Test relationship
      
      let freeEpisodesFR: NSFetchRequest<FreeEpisode> = FreeEpisode.fetchRequest()
      freeEpisodesFR.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(FreeEpisode.episodeId), 1])
      let free = try CoreDataManager.shared.managedContext.fetch(freeEpisodesFR).first
      
      XCTAssertNotNil(free)
      XCTAssertEqual(free!.episode.title, "title1") // Test relationship
      
      let learningPathFR: NSFetchRequest<LearningPath> = LearningPath.fetchRequest()
      let paths = try CoreDataManager.shared.managedContext.fetch(learningPathFR)
      
      XCTAssertEqual(paths.count, 1)
    }
    catch {
      XCTFail("Cannot decode home data. \(error.localizedDescription)")
    }
  }
  
  /// -------------------------------------------------------
  /// helper methods
  /// -------------------------------------------------------
  private func makeHomeDataForUnsigned() -> Data {
    let serverResponse = #"""
    {
      "type": 1,
      "episodes": [
        {
          "id": 1,
          "title": "title1",
          "coverUrl": "https://image.boxue.io/test-img1.jpg",
          "duration": 100,
          "tagString": "tt1,tt2",
          "type": 1,
          "level": 1,
          "summary": "test1 video summary.",
          "updatedAt": "2019-10-13 09:34:55"
        },
        {
          "id": 2,
          "title": "title2",
          "coverUrl": "https://image.boxue.io/test-img2.jpg",
          "duration": 100,
          "tagString": "tt3,tt4",
          "type": 1,
          "level": 1,
          "summary": "test2 video summary.",
          "updatedAt": "2019-10-13 09:35:55"
        }
      ],
      "recentUpdate": [
        {
          "episodeId": 1
        },
        {
          "episodeId": 2
        }
      ],
      "freeEpisodes": [
        {
          "episodeId": 1
        },
        {
          "episodeId": 2
        }
      ],
      "learningPaths": [
        {
          "title": "Learning Path1",
          "coverUrl": "https://image.boxue.io/learning-path-1.jpg",
          "summary": "Learning path1 summary",
          "totalEpisodes": 1,
          "totalDuration": 11
        }
      ]
    }
    """#
    print(serverResponse)
    return serverResponse.data(using: .utf8)!
  }
}
