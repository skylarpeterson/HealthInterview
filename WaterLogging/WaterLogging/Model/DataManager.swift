//
//  DataManager.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum DataKeys: String {
  case todayAmount = "amountConsumed"
  case goal = "goal"
}

class DataManager {

  static let shared = DataManager()

  // MARK: - Today

  lazy var todayIntake: WaterIntake = {
    var intake = loadIntake(forDate: Date())
    if intake == nil {
      intake = addEntry(forDate: Date())
    }
    return intake!
  }()

  // MARK: - Goal

  func intakeGoal() -> Int {
    // If this is our first time opening the app, set the default goal to be 80 oz
    if !UserDefaults.standard.bool(forKey: "FirstOpenCompleted") {
      setIntakeGoal(goal: 80)
      UserDefaults.standard.set(true, forKey: "FirstOpenCompleted")
      return 80
    }
    return UserDefaults.standard.integer(forKey: DataKeys.goal.rawValue)
  }

  func setIntakeGoal(goal: Int) {
    UserDefaults.standard.set(goal, forKey: DataKeys.goal.rawValue)
    todayIntake.goal = Int64(goal)
    do {
      try todayIntake.managedObjectContext?.save()
    } catch {
      print("Error saving amount consumed change for \(todayIntake)")
    }
  }

  // MARK: - Helpers

  func addEntry(forDate date: Date) -> WaterIntake {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext

    let intake = WaterIntake(amountConsumed: 0, date: date, goal: Int64(intakeGoal()), insertIntoManagedObjectContext: managedContext)
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

  // MARK: - Observation

  func addObserver(observer: NSObject, forKey key: DataKeys) {
    todayIntake.addObserver(observer, forKeyPath: key.rawValue, options: .new, context: nil)
  }

}
