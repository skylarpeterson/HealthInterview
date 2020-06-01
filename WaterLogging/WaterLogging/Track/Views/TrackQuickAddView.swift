//
//  TrackQuickAddView.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TrackQuickAddView: WaterLoggingWidgetView {

  private let stackView: UIStackView
  private let fourOzButton = VerticalButton(padding: 8.0)
  private let eightOzButton = VerticalButton(padding: 8.0)
  private let sixteenOzButton = VerticalButton(padding: 8.0)

  var delegate: TrackDelegate?

  override init(frame: CGRect) {
    stackView = UIStackView(arrangedSubviews: [fourOzButton, eightOzButton, sixteenOzButton])
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    stackView = UIStackView(arrangedSubviews: [fourOzButton, eightOzButton, sixteenOzButton])
    super.init(coder: coder)
  }

  override func setup() {
    super.setup()

    titleLabel.text = "Quick Add"

    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false

    fourOzButton.verticalImageView.image = UIImage(named: "water_4")
    fourOzButton.verticalTitleLabel.text = "4 oz"
    fourOzButton.addTarget(self, action: #selector(fourButtonAction), for: .touchUpInside)

    eightOzButton.verticalImageView.image = UIImage(named: "water_8")
    eightOzButton.verticalTitleLabel.text = "8 oz"
    eightOzButton.addTarget(self, action: #selector(eightButtonAction), for: .touchUpInside)

    sixteenOzButton.verticalImageView.image = UIImage(named: "water_16")
    sixteenOzButton.verticalTitleLabel.text = "16 oz"
    sixteenOzButton.addTarget(self, action: #selector(sixteenButtonAction), for: .touchUpInside)
  }

  override func setupConstraints() {
    super.setupConstraints()

    widgetContainerView.addSubview(stackView)

    stackView.topAnchor.constraint(equalTo: widgetContainerView.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: widgetContainerView.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: widgetContainerView.trailingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: widgetContainerView.bottomAnchor).isActive = true
    stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70.0).isActive = true
  }

  // MARK: - Button Actions

  @objc func fourButtonAction() {
    delegate?.addWater(amount: 4)
  }

  @objc func eightButtonAction() {
    delegate?.addWater(amount: 8)
  }

  @objc func sixteenButtonAction() {
    delegate?.addWater(amount: 16)
  }

}
