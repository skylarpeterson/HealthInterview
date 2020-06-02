//
//  WaterIntake+CoreDataProperties.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension WaterIntake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterIntake> {
        return NSFetchRequest<WaterIntake>(entityName: "WaterIntake")
    }

    @NSManaged public var amountConsumed: Int64
    @NSManaged public var date: Date
    @NSManaged public var goal: Int64

}

extension WaterIntake {

  convenience init(amountConsumed: Int64, date: Date, goal: Int64, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
    let entity = NSEntityDescription.entity(forEntityName: "WaterIntake", in: context)!
    self.init(entity: entity, insertInto: context)

    self.amountConsumed = amountConsumed
    self.date = date
    self.goal = goal
  }

}
