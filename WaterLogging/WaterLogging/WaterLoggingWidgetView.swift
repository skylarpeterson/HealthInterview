//
//  WaterLoggingWidgetView.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class WaterLoggingWidgetView: UIView {

  let titleLabel = UILabel()
  let widgetContainerView = UIView()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  func setup() {
    titleLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)

    widgetContainerView.backgroundColor = .systemGray6
    widgetContainerView.layer.cornerRadius = 10.0
    widgetContainerView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(widgetContainerView)

    setupConstraints()
  }

  func setupConstraints() {
    titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

    widgetContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: itemPadding).isActive = true
    widgetContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    widgetContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    widgetContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }

}
