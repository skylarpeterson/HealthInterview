//
//  VisualizeGoalView.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class VisualizeGoalView: WaterLoggingWidgetView {

  let goalLabel = UILabel()
  let goalValueLabel = UILabel()
  let updateButton = UIButton()

  override func setup() {
    super.setup()

    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none

    //let today = formatter.string(from: Date())

    goalLabel.text = "Current Goal"
    goalLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
    goalLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    goalLabel.translatesAutoresizingMaskIntoConstraints = false

    goalValueLabel.text = "\(DataManager.shared.intakeGoal()) oz"
    goalValueLabel.textAlignment = .right
    goalValueLabel.font = UIFont.systemFont(ofSize: 20.0)
    goalValueLabel.translatesAutoresizingMaskIntoConstraints = false

    updateButton.setTitle("Update Goal", for: .normal)
    updateButton.setTitleColor(.systemBlue, for: .normal)
    updateButton.translatesAutoresizingMaskIntoConstraints = false
  }

  override func setupConstraints() {
    super.setupConstraints()

    // Goal Labels

    widgetContainerView.addSubview(goalLabel)
    widgetContainerView.addSubview(goalValueLabel)

    goalLabel.topAnchor.constraint(equalTo: widgetContainerView.topAnchor, constant: 20.0).isActive = true
    goalLabel.leadingAnchor.constraint(equalTo: widgetContainerView.leadingAnchor, constant: 15.0).isActive = true

    goalValueLabel.firstBaselineAnchor.constraint(equalTo: goalLabel.firstBaselineAnchor).isActive = true
    goalValueLabel.trailingAnchor.constraint(equalTo: widgetContainerView.trailingAnchor, constant: -15.0).isActive = true

    // Line and Button

    let lineView = UIView()
    lineView.backgroundColor = .systemGray4
    lineView.translatesAutoresizingMaskIntoConstraints = false
    widgetContainerView.addSubview(lineView)
    widgetContainerView.addSubview(updateButton)

    lineView.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 20.0).isActive = true
    lineView.leadingAnchor.constraint(equalTo: widgetContainerView.leadingAnchor, constant: 15.0).isActive = true
    lineView.trailingAnchor.constraint(equalTo: widgetContainerView.trailingAnchor, constant: -15.0).isActive = true
    lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

    updateButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10.0).isActive = true
    updateButton.centerXAnchor.constraint(equalTo: widgetContainerView.centerXAnchor).isActive = true
    updateButton.bottomAnchor.constraint(equalTo: widgetContainerView.bottomAnchor, constant: -10.0).isActive = true
  }

}
