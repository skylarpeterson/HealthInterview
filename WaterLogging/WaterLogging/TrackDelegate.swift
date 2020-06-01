//
//  TrackDelegate.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol TrackDelegate {
  func addWater(amount: Int)
  func showMessage(title: String?, message: String)
}
