//
//  ContactUsViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/5.
//  Copyright © 2019 Mars. All rights reserved.
//
import Combine
import Foundation

public class ContactUsViewModel: ObservableObject {
  @Published public var email: String = ""
  @Published public var title: String = ""
  @Published public var content: String = {
    let formatter = DateFormatter.normal
    let datetime = formatter.string(from: Date())
    
    return "\n\n\(datetime)"
  }()
  
  public var isPostSuccess = PassthroughSubject<Bool, Never>()
  public var isSendBtnEnabled: AnyPublisher<Bool, Never> {
    return Publishers
      .CombineLatest3($email, $title, $content)
      .map { email, title, content in
        (email.count >= 6) && email.isValidEmail && title != "" && content != ""
      }
      .receive(on: RunLoop.main)
      .share()
      .eraseToAnyPublisher()
  }
  
  public init() {}
  
  private let contactUs = BxContactUs()
  private var disposables = Set<AnyCancellable>()
  
  public func sendMessage() {
    let msg = ContactUsMessage(email: email, title: title, message: content)
    
    contactUs.send(msg)
      .sink(
        receiveCompletion: { [weak self] in
          switch $0 {
          case .failure:
            self?.isPostSuccess.send(false)
          case .finished:
            break
          }
        },
        receiveValue: { [weak self] _ in
          self?.isPostSuccess.send(true)
        })
      .store(in: &disposables)
  }
}
