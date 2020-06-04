//
//  VisualizeWaterIntakeViewController.swift
//  WaterLogging
//
//

import UIKit
import MKRingProgressView

class VisualizeWaterIntakeViewController: UIViewController, GoalDelegate {

  private let goalView = VisualizeGoalView(frame: .zero)
  private let progressView = VisualizeProgressView(frame: .zero)

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

    progressView.updateProgress(progress: progress, animated: true)
  }

  // Set Up

  private func setUp() {
    view.backgroundColor = .systemBackground
    title = "Visualize"

    goalView.delegate = self
    goalView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(goalView)

    progressView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(progressView)

    setUpConstraints()
  }

  private func setUpConstraints() {
    progressView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 20.0).isActive = true
    progressView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
    progressView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true

    goalView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20.0).isActive = true
    goalView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor).isActive = true
    goalView.trailingAnchor.constraint(equalTo: progressView.trailingAnchor).isActive = true
  }

  // MARK: - GoalDelegate

  func promptUpdateGoal() {
    let alert = UIAlertController(title: "Update Daily Goal", message: "Enter a new daily goal for water intake.", preferredStyle: .alert)

    alert.addTextField { (textField) in
      textField.text = "\(DataManager.shared.intakeGoal())"
      textField.keyboardType = .numberPad
    }

    let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned alert] _ in
      if let goalField = alert.textFields?.first {
        if let newGoalStr = goalField.text {
          if let newGoal = Int(newGoalStr) {
            DataManager.shared.setIntakeGoal(goal: newGoal)
          }
        }
      }
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

    alert.addAction(saveAction)
    alert.addAction(cancelAction)

    present(alert, animated: true, completion: nil)
  }

}

