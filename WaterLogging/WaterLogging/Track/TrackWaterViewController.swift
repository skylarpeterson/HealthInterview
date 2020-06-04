//
//  TrackWaterViewController.swift
//  WaterLogging
//
//

import UIKit

class TrackWaterViewController: UIViewController, TrackDelegate {

  private let customInputView = TrackCustomInputView(frame: .zero)
  private let quickAddView = TrackQuickAddView(frame: .zero)

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setUp()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Initialization

  private func setUp() {
    title = "Track"
    view.backgroundColor = .systemBackground

    customInputView.delegate = self
    customInputView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(customInputView)

    quickAddView.delegate = self
    quickAddView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(quickAddView)

    setUpConstraints()
  }

  private func setUpConstraints() {
    customInputView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 20.0).isActive = true
    customInputView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
    customInputView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true

    quickAddView.topAnchor.constraint(equalTo: customInputView.bottomAnchor, constant: 20.0).isActive = true
    quickAddView.leadingAnchor.constraint(equalTo: customInputView.leadingAnchor).isActive = true
    quickAddView.trailingAnchor.constraint(equalTo: customInputView.trailingAnchor).isActive = true
  }

  // MARK: - TrackDelegate

  func addWater(amount: Int) {
    let today = DataManager.shared.todayIntake
    today.amountConsumed = today.amountConsumed + Int64(amount)
    do {
      try today.managedObjectContext?.save()
    } catch {
      print("Error saving amount consumed change for \(today)")
    }

    let ounce = (amount == 1) ? "ounce" : "ounces"
    let message = "Added \(amount) \(ounce) of water toward your daily goal"
    showMessage(title: "Success!", message: message)
  }

  func showMessage(title: String?, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okayAction = UIAlertAction.init(title: "Okay", style: .default, handler: nil)
    alert.addAction(okayAction)
    present(alert, animated: true, completion: nil)
  }

}

