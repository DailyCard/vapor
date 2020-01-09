//
//  CoreDataManager.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/10/4.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
  public static let shared = CoreDataManager()
  
  let identifier = "io.boxue.BoxueDataKit"
  let model = "BxData"
  
  public lazy var persistentContainer: NSPersistentContainer = {
    let dataKitBundle = Bundle(identifier: self.identifier)!
    let modelUrl = dataKitBundle.url(forResource: self.model, withExtension: "momd")!
    let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl)!
    let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel)
    
    container.loadPersistentStores(completionHandler: {
      (storeDescription, error) in
      
      if let error = error {
        fatalError("Cannot load core data store.")
      }
    })
    
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    
    return container
  }()
  
  public lazy var managedContext: NSManagedObjectContext = {
    self.persistentContainer.viewContext
  }()
  
  public func saveContext() {
    guard managedContext.hasChanges else { return }
    
    do {
      try managedContext.save()
    }
    catch let error as NSError {
      fatalError("Cannot save core data. Error: \(error), \(error.userInfo)")
    }
  }
  
  public func clearStorage(entityName: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
      try managedContext.execute(batchDeleteRequest)
    }
    catch let error as NSError {
      print("Cannot delete local storage for: \(entityName).\nReason: \(error.localizedDescription)")
    }
  }
}
