//
//  CamperServiceTests.swift
//  CampgroundManagerTests
//
//  Created by Egor Gorskikh on 30.05.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
import CampgroundManager
import CoreData

class CamperServiceTests: XCTestCase {
  
  // MARK: Property
  var camperService: CamperService!
  var coreDataStack: CoreDataStack!

    override func setUp() {
      super.setUp()
      
      coreDataStack = TestCoreDataStack()
      camperService = CamperService(managedObjectContext: coreDataStack.mainContext,
                                    coreDataStack: coreDataStack)
    }

    override func tearDown() {
      super.tearDown()
      
      coreDataStack = nil
      camperService = nil
    }

    func testAddCamper() {
      
      let camper = camperService.addCamper("Foo",
                                           phoneNumber: "Baz")
      
      XCTAssertNotNil(camper, "Camper should not be nil")
      XCTAssertTrue(camper?.fullName == "Foo")
      XCTAssertTrue(camper?.phoneNumber == "Baz")
    }
  
  func testRootContextInSavedAfterAddingCamper() {
    
    let derivedContext = coreDataStack.newDerivedContext()
    camperService = CamperService(managedObjectContext: derivedContext,
                                  coreDataStack: coreDataStack)
    
    expectation(forNotification: .NSManagedObjectContextDidSave,
                object: coreDataStack.mainContext) { _ in
      return true
    }
    
    derivedContext.perform {
      let camper = self.camperService.addCamper("Foo", phoneNumber: "Baz")
      XCTAssertNotNil(camper)
    }
    
    waitForExpectations(timeout: 2.0) { error in
      XCTAssertNil(error, "Save did not occur")
    }
    
  }



}
