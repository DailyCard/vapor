//
//  SwiftUIView.swift
//  Boxue
//
//  Created by Mars on 2019/9/2.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit
import SwiftUI

struct MultilineTextField: UIViewRepresentable {
  @Binding var didChange: String
  
  func makeCoordinator() -> MultilineTextField.Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> UITextView {
    let view = UITextView()
    view.isEditable = true
    view.text = didChange
    view.delegate = context.coordinator
    view.isUserInteractionEnabled = true
    view.textContainer.lineFragmentPadding = 0
    view.backgroundColor = .secondarySystemBackground
    view.font = UIFont.preferredFont(forTextStyle: .body)
    return view
  }
  
  func updateUIView(_ uiView: UITextView, context: Context) {}
  
  class Coordinator: NSObject, UITextViewDelegate {
    var mtv: MultilineTextField
    
    init(_ mtv: MultilineTextField) {
      self.mtv = mtv
    }
    
    func textViewDidChange(_ textView: UITextView) {
      mtv.didChange = textView.text
    }
  }
}

#if DEBUG

fileprivate struct ContentView: View {
  @State var didChange: String = "Hello"
  
  var body: some View {
    MultilineTextField(didChange: $didChange)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

#endif
