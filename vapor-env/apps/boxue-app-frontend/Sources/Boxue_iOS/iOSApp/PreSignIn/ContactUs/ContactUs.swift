//
//  SwiftUIView.swift
//  Boxue
//
//  Created by Mars on 2019/9/1.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import Combine
import BoxueUIKit
import BoxueDataKit

struct ContactUs: View {
  @ObservedObject var viewModel: ContactUsViewModel
  
  init(contactUsViewModel: ContactUsViewModel) {
    self.viewModel = contactUsViewModel
  }
  
  var body: some View {
    ZStack {
      Color(UIColor.secondarySystemBackground)
        .edgesIgnoringSafeArea(.bottom)
      
      VStack {
        VStack(alignment: .leading, spacing: 0) {
          HStack {
            Text("CONTACT_US_EMAIL")
              .foregroundColor(Color(.secondaryLabel))
            TextField("", text: $viewModel.email)
              .frame(height: 50)
              .textContentType(.emailAddress)
              .keyboardType(.emailAddress)
          }

          Divider().padding([.top, .bottom], 1)

          HStack {
            Text("CONTACT_US_TITLE")
              .foregroundColor(Color(.secondaryLabel))
            TextField("", text: $viewModel.title)
              .frame(height: 50)
          }

          Divider().padding([.top, .bottom], 1)

          /// The background of `MultilineTextField` must be defined
          /// in *MultilineTextField.swift* in the current version of SwiftUI.
          MultilineTextField(didChange: $viewModel.content)
        } // End VStack
        .padding(.leading, 15)
        
        Spacer()
        
        Text("RIGHTS_INFO")
          .font(.footnote)
          .multilineTextAlignment(.center)
          .foregroundColor(Color(.tertiaryLabel))
          .padding(.bottom, 10)
          .frame(width: 300.0)
      }// End VStack
      .modifier(KeyboardAdaptor())
      .animation(.easeIn(duration: 0.2))
    } // End ZStack
  }
  
  var isDisabled: Bool {
    return viewModel.email == "" || viewModel.title == "" || viewModel.content == ""
  }
}

struct ContactUs_Previews: PreviewProvider {
  static var previews: some View {
    Group {
       ContactUs(contactUsViewModel: ContactUsViewModel())
          .environment(\.colorScheme, .light)

       ContactUs(contactUsViewModel: ContactUsViewModel())
          .environment(\.colorScheme, .dark)
    }
  }
}
