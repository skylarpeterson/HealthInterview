//
//  TrackCustomInputView.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TrackCustomInputView: WaterLoggingWidgetView {

  private let amountTextField = UITextField()
  private let ounceLabel = UILabel()
  private let totalLabel = UILabel()
  private let addButton = UIButton()

  var delegate: TrackDelegate?

  // MARK: - Overrides

  override func setup() {
    super.setup()

    titleLabel.text = "Add Water"

    amountTextField.placeholder = "0"
    amountTextField.font = UIFont.systemFont(ofSize: 80.0, weight: .medium)
    amountTextField.keyboardType = .numberPad
    amountTextField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    amountTextField.translatesAutoresizingMaskIntoConstraints = false
    addDoneButtonOnKeyboard()

    ounceLabel.text = "oz"
    ounceLabel.font = UIFont.systemFont(ofSize: 30.0)
    ounceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    ounceLabel.translatesAutoresizingMaskIntoConstraints = false

    updateTotal(amount: DataManager.shared.todayIntake.amountConsumed)
    totalLabel.font = UIFont.systemFont(ofSize: 17.0)
    totalLabel.textColor = .systemGray
    totalLabel.translatesAutoresizingMaskIntoConstraints = false

    addButton.setTitle("Add", for: .normal)
    addButton.setTitleColor(.systemBlue, for: .normal)
    addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    addButton.translatesAutoresizingMaskIntoConstraints = false

    DataManager.shared.addObserver(observer: self, forKey: DataKeys.todayAmount)
  }

  override func setupConstraints() {
    super.setupConstraints()

    let entryContainer = UIView()
    entryContainer.addSubview(amountTextField)
    entryContainer.addSubview(ounceLabel)
    entryContainer.translatesAutoresizingMaskIntoConstraints = false

    let container = UIView()
    container.addSubview(entryContainer)
    container.translatesAutoresizingMaskIntoConstraints = false
    widgetContainerView.addSubview(container)

    container.topAnchor.constraint(equalTo: widgetContainerView.topAnchor).isActive = true
    container.leadingAnchor.constraint(equalTo: widgetContainerView.leadingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: widgetContainerView.trailingAnchor).isActive = true

    entryContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 40.0).isActive = true
    entryContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -40.0).isActive = true
    entryContainer.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    entryContainer.widthAnchor.constraint(lessThanOrEqualTo: container.widthAnchor, multiplier: 1.0).isActive = true

    amountTextField.topAnchor.constraint(equalTo: entryContainer.topAnchor).isActive = true
    amountTextField.leadingAnchor.constraint(equalTo: entryContainer.leadingAnchor).isActive = true
    amountTextField.bottomAnchor.constraint(equalTo: entryContainer.bottomAnchor).isActive = true

    ounceLabel.firstBaselineAnchor.constraint(equalTo: amountTextField.firstBaselineAnchor).isActive = true
    ounceLabel.leadingAnchor.constraint(equalTo: amountTextField.trailingAnchor, constant: 5.0).isActive = true
    ounceLabel.trailingAnchor.constraint(equalTo: entryContainer.trailingAnchor).isActive = true

    widgetContainerView.addSubview(totalLabel)
    totalLabel.topAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    totalLabel.centerXAnchor.constraint(equalTo: widgetContainerView.centerXAnchor).isActive = true

    let lineView = UIView()
    lineView.backgroundColor = .systemGray4
    lineView.translatesAutoresizingMaskIntoConstraints = false
    widgetContainerView.addSubview(lineView)
    widgetContainerView.addSubview(addButton)

    lineView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 10.0).isActive = true
    lineView.leadingAnchor.constraint(equalTo: widgetContainerView.leadingAnchor, constant: 10.0).isActive = true
    lineView.trailingAnchor.constraint(equalTo: widgetContainerView.trailingAnchor, constant: -10.0).isActive = true
    lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

    addButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10.0).isActive = true
    addButton.centerXAnchor.constraint(equalTo: widgetContainerView.centerXAnchor).isActive = true
    addButton.bottomAnchor.constraint(equalTo: widgetContainerView.bottomAnchor, constant: -10.0).isActive = true
  }

  // Done Button Source: https://stackoverflow.com/questions/28338981/how-to-add-done-button-to-numpad-in-ios-using-swift

  func addDoneButtonOnKeyboard(){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    doneToolbar.barStyle = .default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

    let items = [flexSpace, done]
    doneToolbar.items = items
    doneToolbar.sizeToFit()

    amountTextField.inputAccessoryView = doneToolbar
  }

  // MARK: - Private Helpers

  private func updateTotal(amount: Int64) {
    totalLabel.text = "Today's Total: \(DataManager.shared.todayIntake.amountConsumed) oz"
  }

  // MARK: - Button Actions

  @objc func doneButtonAction() {
    amountTextField.resignFirstResponder()
  }

  @objc func addButtonAction() {
    if let amountText = amountTextField.text {
      if let amount = Int(amountText) {
        delegate?.addWater(amount: amount)
      } else {
        delegate?.showMessage(title: nil, message: "Enter an amount of water to add it towards your daily total.")
      }
    }
    amountTextField.text = nil
  }

  // MARK: - Data Observation

  override func observeValue(forKeyPath keyPath: String?,
                             of object: Any?,
                             change: [NSKeyValueChangeKey : Any]?,
                             context: UnsafeMutableRawPointer?) {
    if keyPath == DataKeys.todayAmount.rawValue {
      if let change = change {
        if let new = change[NSKeyValueChangeKey.newKey] as? Int64 {
          updateTotal(amount: new)
        }
      }
    }
  }

}
