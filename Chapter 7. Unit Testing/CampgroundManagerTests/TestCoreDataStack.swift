//
//  TestCoreDataStack.swift
//  CampgroundManagerTests
//
//  Created by Egor Gorskikh on 30.05.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
import CampgroundManager
import CoreData

class TestCoreDataStack: CoreDataStack {
  
  override init() {
    super.init()
    
    let container = NSPersistentContainer(name: CoreDataStack.modelName,
                                          managedObjectModel: CoreDataStack.model)
    container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    self.storeContainer = container
  }
  
}
