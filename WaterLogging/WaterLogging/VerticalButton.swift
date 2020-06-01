//
//  VerticalButton.swift
//  WaterLogging
//
//  Created by Skylar Peterson on 6/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {

  var padding: CGFloat = 6.0

  let verticalTitleLabel = UILabel()
  let verticalImageView = UIImageView()

  init(padding: CGFloat) {
    super.init(frame: .zero)
    self.padding = padding
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  func setup() {
    verticalTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    verticalTitleLabel.translatesAutoresizingMaskIntoConstraints = false

    verticalImageView.translatesAutoresizingMaskIntoConstraints = false

    setupConstraints()
  }

  func setupConstraints() {
    addSubview(verticalTitleLabel)
    addSubview(verticalImageView)

    verticalImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    verticalImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true

    verticalTitleLabel.topAnchor.constraint(equalTo: verticalImageView.bottomAnchor, constant: padding).isActive = true
    verticalTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    verticalTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
  }

}
