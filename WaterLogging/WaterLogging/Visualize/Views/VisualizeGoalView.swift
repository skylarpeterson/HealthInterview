//
//  VisualizeGoalView.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

protocol GoalDelegate {
  func promptUpdateGoal()
}

class VisualizeGoalView: WaterLoggingWidgetView {

  let goalLabel = UILabel()
  let goalValueLabel = UILabel()
  let updateButton = UIButton()

  var delegate: GoalDelegate?

  override func setup() {
    super.setup()

    goalLabel.text = "Daily Goal"
    goalLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
    goalLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    goalLabel.translatesAutoresizingMaskIntoConstraints = false

    goalValueLabel.text = "\(DataManager.shared.intakeGoal()) oz"
    goalValueLabel.textAlignment = .right
    goalValueLabel.font = UIFont.systemFont(ofSize: 20.0)
    goalValueLabel.translatesAutoresizingMaskIntoConstraints = false

    updateButton.setTitle("Update Goal", for: .normal)
    updateButton.setTitleColor(.systemBlue, for: .normal)
    updateButton.addTarget(self, action: #selector(updateGoalAction), for: .touchUpInside)
    updateButton.translatesAutoresizingMaskIntoConstraints = false

    DataManager.shared.addObserver(observer: self, forKey: DataKeys.goal)
  }

  override func setupConstraints() {
    super.setupConstraints()

    // Goal Labels

    widgetContainerView.addSubview(goalLabel)
    widgetContainerView.addSubview(goalValueLabel)

    goalLabel.topAnchor.constraint(equalTo: widgetContainerView.topAnchor, constant: mainViewPadding).isActive = true
    goalLabel.leadingAnchor.constraint(equalTo: widgetContainerView.leadingAnchor, constant: visualizeGoalHorizontalPadding).isActive = true

    goalValueLabel.firstBaselineAnchor.constraint(equalTo: goalLabel.firstBaselineAnchor).isActive = true
    goalValueLabel.trailingAnchor.constraint(equalTo: widgetContainerView.trailingAnchor, constant: -visualizeGoalHorizontalPadding).isActive = true

    // Line and Button

    let lineView = UIView()
    lineView.backgroundColor = .systemGray4
    lineView.translatesAutoresizingMaskIntoConstraints = false
    widgetContainerView.addSubview(lineView)
    widgetContainerView.addSubview(updateButton)

    lineView.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: mainViewPadding).isActive = true
    lineView.leadingAnchor.constraint(equalTo: widgetContainerView.leadingAnchor, constant: visualizeGoalHorizontalPadding).isActive = true
    lineView.trailingAnchor.constraint(equalTo: widgetContainerView.trailingAnchor, constant: -visualizeGoalHorizontalPadding).isActive = true
    lineView.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true

    updateButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: itemPadding).isActive = true
    updateButton.centerXAnchor.constraint(equalTo: widgetContainerView.centerXAnchor).isActive = true
    updateButton.bottomAnchor.constraint(equalTo: widgetContainerView.bottomAnchor, constant: -itemPadding).isActive = true
  }

  // MARK: - Button Actions

  @objc func updateGoalAction() {
    delegate?.promptUpdateGoal()
  }

  // MARK: - Data Observation

  override func observeValue(forKeyPath keyPath: String?,
                             of object: Any?,
                             change: [NSKeyValueChangeKey : Any]?,
                             context: UnsafeMutableRawPointer?) {
    if keyPath == DataKeys.goal.rawValue {
      if let change = change {
        if let new = change[NSKeyValueChangeKey.newKey] as? Int64 {
          goalValueLabel.text = "\(new)"
        }
      }
    }
  }

}
