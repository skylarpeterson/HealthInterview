//
//  DataManager.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import CoreData

class DataManager {

  static let shared = DataManager()

  lazy var todayIntake: WaterIntake = {
    var intake = loadIntake(forDate: Date())
    if intake == nil {
      intake = addEntry(forDate: Date())
    }
    return intake!
  }()

  func addEntry(forDate date: Date) -> WaterIntake {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext

    let intake = WaterIntake(amountConsumed: 0, date: date, goal: 24, insertIntoManagedObjectContext: managedContext)
    do {
      try managedContext.save()
    } catch {
      print("Failed to save while creating new intake for date: \(date)")
    }
    return intake
  }

  func loadIntake(forDate date: Date) -> WaterIntake? {
    let calendar = Calendar.current

    let dateFrom = calendar.startOfDay(for: date)
    if let dateTo = calendar.date(byAdding: .day, value: 1, to: date) {
      let intakes = loadIntakes(startDate: dateFrom, endDate: dateTo)
      if let intake = intakes.first {
        return intake
      }
    }

    return nil
  }

  // Used this as a reference https://stackoverflow.com/questions/40312105/core-data-predicate-filter-by-todays-date

  func loadIntakes(startDate: Date, endDate: Date) -> [WaterIntake] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<WaterIntake> = WaterIntake.fetchRequest()

    let fromPredicate = NSPredicate(format: "date >= %@", startDate as NSDate)
    let toPredicate = NSPredicate(format: "date < %@", endDate as NSDate)
    let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
    fetchRequest.predicate = datePredicate

    do {
      return try managedContext.fetch(fetchRequest)
    } catch {
      print("Could not load results for start date \(startDate), end date \(endDate)")
    }

    return []
  }

}
