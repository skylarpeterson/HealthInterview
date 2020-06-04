//
//  VisualizeProgressView.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import MKRingProgressView

class VisualizeProgressView: WaterLoggingWidgetView {

  private let ringView = RingProgressView(frame: .zero)
  private let consumedLabel = UILabel()

  override func setup() {
    super.setup()

    titleLabel.text = "Progress"

    ringView.startColor = .systemBlue
    ringView.endColor = .systemBlue
    ringView.ringWidth = 40
    ringView.translatesAutoresizingMaskIntoConstraints = false

    consumedLabel.text = consumedText()
    consumedLabel.textAlignment = .center
    consumedLabel.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
    consumedLabel.numberOfLines = 0
    consumedLabel.translatesAutoresizingMaskIntoConstraints = false
  }

  override func setupConstraints() {
    super.setupConstraints()

    widgetContainerView.addSubview(ringView)
    widgetContainerView.addSubview(consumedLabel)

    ringView.topAnchor.constraint(equalTo: widgetContainerView.topAnchor, constant: 20.0).isActive = true
    ringView.bottomAnchor.constraint(equalTo: widgetContainerView.bottomAnchor, constant: -20.0).isActive = true
    ringView.centerXAnchor.constraint(equalTo: widgetContainerView.centerXAnchor).isActive = true
    ringView.widthAnchor.constraint(equalTo: widgetContainerView.widthAnchor, multiplier: 0.8).isActive = true
    ringView.heightAnchor.constraint(equalTo: widgetContainerView.widthAnchor, multiplier: 0.8).isActive = true

    consumedLabel.centerXAnchor.constraint(equalTo: widgetContainerView.centerXAnchor).isActive = true
    consumedLabel.centerYAnchor.constraint(equalTo: widgetContainerView.centerYAnchor).isActive = true
    consumedLabel.widthAnchor.constraint(equalTo: ringView.widthAnchor, multiplier: 0.6).isActive = true
    consumedLabel.heightAnchor.constraint(equalTo: ringView.heightAnchor, multiplier: 0.6).isActive = true
  }

  // MARK: - Helpers

  func consumedText() -> String {
    return "\(DataManager.shared.todayIntake.amountConsumed)/\(DataManager.shared.intakeGoal()) oz"
  }

  func updateProgress(progress: Double, animated: Bool) {
    if animated {
      UIView.animate(withDuration: 0.5) {
        self.ringView.progress = progress
      }
    } else {
      ringView.progress = progress
    }
    self.consumedLabel.text = consumedText()
  }

}
