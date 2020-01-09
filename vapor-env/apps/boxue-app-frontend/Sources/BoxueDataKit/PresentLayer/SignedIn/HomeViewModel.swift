//
//  HomeViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/11.
//  Copyright © 2019 Mars. All rights reserved.
//
import SwiftUI
import Combine
import CoreData
import Foundation

public class HomeViewModel: ObservableObject {
  @Published public var homeData: HomeData = HomeData()
  @Published public var hasLocalData: Bool = HomeViewModel.hasLocalCache()
  @Published public var isLoadingError: Bool = false
  @Published public var isSignedIn: Bool
  
  public lazy private(set) var histories: Binding<[WatchingHistory]> = {
    return Binding<[WatchingHistory]>(get: { () -> [WatchingHistory] in
      if let histories = self.homeData.watchingHistories {
        return histories
      }
      
      return []
    }, set: {
      self.homeData.watchingHistories = $0
    })
  }()
  
  public lazy private(set) var freeEpisodes: Binding<[FreeEpisode]> = {
    return Binding<[FreeEpisode]>(get: { () -> [FreeEpisode] in
      if let freeEpisodes = self.homeData.freeEpisodes {
        return freeEpisodes
      }
      
      return []
    }, set: {
      self.homeData.freeEpisodes = $0
    })
  }()
  
  private var disposables = Set<AnyCancellable>()
  private let userSessionRepository: UserSessionRepository
  
  public init(userSessionRepository: UserSessionRepository) {
    self.userSessionRepository = userSessionRepository
    self.isSignedIn = self.userSessionRepository.isSignedIn()
    
    if HomeViewModel.hasLocalCache() {
      homeData = loadHomeData()
    }
    
    fetchHomeData()
  }
  
  public func fetchHomeData() {
    if self.isLoadingError && !self.hasLocalData {
      self.isLoadingError.toggle()
    }
    
    HomeDataAPI(remoteUserSession: userSessionRepository.remoteUserSession())
      .get()
      .receive(on: RunLoop.main)
      .sink(
        receiveCompletion: {
          switch $0 {
          case .failure:
            if !self.hasLocalData {
              DispatchQueue.main.async {
                self.isLoadingError = true
              }
            }
          case .finished:
            break
          }
        },
        receiveValue: {
          self.homeData = $0
          self.hasLocalData = true
        })
      .store(in: &disposables)
  }
  
  private static func hasLocalCache() -> Bool {
    let context = CoreDataManager.shared.managedContext
    let fetchRequest: NSFetchRequest<Episode> = Episode.fetchRequest()
    
    do {
      let episodes = try context.fetch(fetchRequest)
      if episodes.isEmpty { return false }
      
      return true
    }
    catch {
      return false
    }
  }
  
  private func loadHomeData() -> HomeData {
    return HomeData(isSignedIn: userSessionRepository.isSignedIn())
  }
}
