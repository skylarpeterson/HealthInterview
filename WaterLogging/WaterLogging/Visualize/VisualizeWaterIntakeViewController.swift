//
//  VisualizeWaterIntakeViewController.swift
//  WaterLogging
//
//

import UIKit
import MKRingProgressView

class VisualizeWaterIntakeViewController: UIViewController {

  private let ringView = RingProgressView(frame: .zero)

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setUp()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let currentIntake = DataManager.shared.todayIntake.amountConsumed
    let currentGoal = DataManager.shared.intakeGoal()
    let progress: Double = Double(currentIntake)/Double(currentGoal)

    UIView.animate(withDuration: 0.5) {
      self.ringView.progress = progress
    }
  }

  // Set Up

  private func setUp() {
    view.backgroundColor = .systemBackground
    title = "Visualize"

    ringView.startColor = .systemBlue
    ringView.endColor = .systemBlue
    ringView.ringWidth = 40

    setUpConstraints()
  }

  private func setUpConstraints() {
    ringView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(ringView)

    ringView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    ringView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    ringView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
    ringView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
  }

}

