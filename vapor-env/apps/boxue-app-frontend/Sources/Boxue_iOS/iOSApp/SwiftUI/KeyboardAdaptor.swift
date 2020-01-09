//
//  KeyboardAdaptor.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/2.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import Combine

struct KeyboardAdaptor: ViewModifier {
  @State var currentHeight: CGFloat = 0
  
  func body(content: Content) -> some View {
    content
      .padding(.bottom, currentHeight)
      .edgesIgnoringSafeArea(currentHeight == 0 ? Edge.Set() : .bottom)
      .onAppear(perform: subscribeToKeyboardEvents)
  }
  
  private let keyboardWillOpen = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillShowNotification)
    .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
    .map { $0.height }
  
  private let keyboardWillHide = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillHideNotification)
    .map { _ in CGFloat.zero }
  
  private func subscribeToKeyboardEvents() {
    _ = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
      .subscribe(on: RunLoop.main)
      .assign(to: \.currentHeight, on: self)
  }
}


