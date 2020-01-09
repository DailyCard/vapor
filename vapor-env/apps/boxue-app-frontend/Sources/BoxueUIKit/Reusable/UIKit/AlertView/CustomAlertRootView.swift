//
//  CustomAlertView.swift
//  BoxueUIKit
//
//  Created by Mars on 2019/8/28.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit

class CustomAlertRootView: NiblessView {
  let icon: UIImage
  let title: String
  let detail: String
  let buttonText: String
  
  let blurView: UIVisualEffectView = {
    let bv = UIVisualEffectView()
    bv.translatesAutoresizingMaskIntoConstraints = false
    bv.effect = UIBlurEffect(style: .systemThinMaterial)
    
    return bv
  }()
  
  lazy var alertContainer: UIView = {
    let view = UIView()
    view.addSubview(blurView)
    view.layer.cornerRadius = 12
    view.clipsToBounds = true
    return view
  }()
  
  lazy var titleImage: UIImageView = {
    let imageView = UIImageView()
    
    imageView.image = icon
    imageView.contentMode = .center
    
    imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    return imageView
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = title
    label.numberOfLines = 0
    label.textColor = .label
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    return label
  }()
  
  lazy var detailLabel: UILabel = {
    let label = UILabel()
    label.text = detail
    label.numberOfLines = 0
    label.textColor = .label
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    
    return label
  }()
  
  lazy var button: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(buttonText, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.clipsToBounds = true
    return button
  }()
  
  init(icon: UIImage, titleLabel: String, detailLabel: String, buttonText: String, frame: CGRect = .zero) {
    self.icon = icon
    self.title = titleLabel
    self.detail = detailLabel
    self.buttonText = buttonText
    
    super.init(frame: frame)
    self.backgroundColor = .black
    self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.4)
  }
  
  override func layoutSubviews() {
    super.didMoveToWindow()
    constructViewHierarchy()
    activateConstraints()
    self.layoutIfNeeded()
    
    button.addBorder(on: .top, color: .systemGray2, size: 0.9)
  }
  
  func constructViewHierarchy() {
    addSubview(alertContainer)
    alertContainer.addSubview(titleImage)
    alertContainer.addSubview(titleLabel)
    alertContainer.addSubview(detailLabel)
    alertContainer.addSubview(button)
  }
  
  func activateConstraints() {
    addConstraintBlurView()
    activateConstraintAlertContainer()
    activateConstraintTitleImage()
    activateConstraintTitleLabel()
    activateConstraitDetailLabel()
    activateConstraintButton()
  }
  
  func addConstraintBlurView() {
    let top = blurView.topAnchor.constraint(equalTo: alertContainer.topAnchor)
    let leading = blurView.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor)
    let trailing = blurView.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor)
    let bottom = blurView.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing, bottom])
  }
  
  func activateConstraintAlertContainer() {
    alertContainer.translatesAutoresizingMaskIntoConstraints = false
    
    let top = alertContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 156)
    let leading = alertContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 52)
    let trailing = alertContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -52)
    let bottom = alertContainer.bottomAnchor.constraint(equalTo: button.bottomAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing, bottom])
  }
  
  func activateConstraintTitleImage() {
    titleImage.translatesAutoresizingMaskIntoConstraints = false
    
    let top = titleImage.topAnchor.constraint(equalTo: alertContainer.topAnchor, constant: 22)
    let centerX = titleImage.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor)
    
    NSLayoutConstraint.activate([top, centerX])
  }
  
  func activateConstraintTitleLabel() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let top = titleLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 14)
    let leading = titleLabel.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: 22)
    let trailing = titleLabel.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -22)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  func activateConstraitDetailLabel() {
    detailLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let top = detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
    let leading = detailLabel.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: 22)
    let trailing = detailLabel.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -22)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  func activateConstraintButton() {
    button.translatesAutoresizingMaskIntoConstraints = false
    
    let top = button.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 14)
    let leading = button.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor)
    let trailing = button.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
}
