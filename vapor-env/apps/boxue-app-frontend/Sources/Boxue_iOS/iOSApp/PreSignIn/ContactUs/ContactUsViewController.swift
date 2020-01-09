//
//  ContactUs.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/18.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import BoxueUIKit
import BoxueDataKit

public class ContactUsViewController: NiblessViewController {
  let viewModel: ContactUsViewModel
  let hostVC: UIHostingController<ContactUs>
  var barItemR: UIBarButtonItem!
  var disposables = Set<AnyCancellable>()
  
  init(factory: ContactUsViewModelFactory) {
    self.viewModel = factory.makeContactUsViewModel()
    self.hostVC = UIHostingController<ContactUs>(rootView: ContactUs(contactUsViewModel: self.viewModel))
    
    super.init()
    
    title = .contactUs
    
    self.barItemR = UIBarButtonItem(
    title: .contactUsSend,
    style: .plain,
    target: self,
    action: #selector(sendMessage))
    
    navigationItem.rightBarButtonItem = barItemR
    
    viewModel.isSendBtnEnabled
      .receive(on: DispatchQueue.main)
      .assign(to: \.isEnabled, on: barItemR)
      .store(in: &disposables)
    
    viewModel.isPostSuccess
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: {
        if $0 {
          self.presentSuccessAlert()
        }
        else {
          self.presentErrorAlert()
        }
      })
      .store(in: &disposables)
  }
  
  public override func loadView() {
    self.view = UIView()
    addFullScreen(childViewController: hostVC)
  }
  
  func presentErrorAlert() {
    let icon = #imageLiteral(resourceName: "fail")
    let ac = CustomAlertViewController(
      icon: icon,
      titleLabel: .contactUsErrorTitle,
      detailLabel: .contactUsErrorDesc,
      buttonText: "OK")
    
    ac.modalPresentationStyle = .overFullScreen
    present(ac, animated: true)
  }
  
  func presentSuccessAlert() {
    let icon = #imageLiteral(resourceName: "success")
    let ac = CustomAlertViewController(
      icon: icon,
      titleLabel: .contactUsSuccessTitle,
      detailLabel: .contactUsSuccessDesc,
      buttonText: "OK")
    
    ac.modalPresentationStyle = .overFullScreen
    self.present(ac, animated: true)
  }
  
  @objc public func sendMessage() {
    self.view.endEditing(true)
    viewModel.sendMessage()
  }
}

extension String {
  static let contactUsSend = localized(of: "CONTACT_US_SEND")
  static let contactUsSuccessTitle = localized(of: "CONTACT_US_SUCCESS_TITLE")
  static let contactUsSuccessDesc = localized(of: "CONTACT_US_SUCCESS_DESC")
  static let contactUsErrorTitle = localized(of: "CONTACT_US_ERROR_TITLE")
  static let contactUsErrorDesc = localized(of: "CONTACT_US_ERROR_DESC")
}

protocol ContactUsViewModelFactory {
  func makeContactUsViewModel() -> ContactUsViewModel
}
