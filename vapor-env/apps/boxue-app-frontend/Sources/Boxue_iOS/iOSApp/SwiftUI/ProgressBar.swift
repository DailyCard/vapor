//
//  ProgressBar.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/14.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
  var height: CGFloat = 6
  @Binding var value: CGFloat
  
  func getProgressBarWidth(geometry: GeometryProxy) -> CGFloat {
    return geometry.frame(in: .global).size.width * value
  }
  
  func getPercentage() -> String {
    let intValue = Int(ceil(value * 100))
    return "\(intValue) %"
  }
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .trailing) {
//        Text("Progress: \(self.getPercentage())")
        ZStack(alignment: .leading) {
          Rectangle()
            .fill()
            .foregroundColor(Color(.tertiarySystemFill))
            
          Rectangle()
            .fill()
            .foregroundColor(Color(.systemTeal))
            .frame(minWidth: 0,
                   idealWidth: self.getProgressBarWidth(geometry: geometry),
                   maxWidth: self.getProgressBarWidth(geometry: geometry))
            .animation(.default)
        }
        .frame(height: self.height)
      }
      .frame(height: self.height)
    }
  }
}

struct ProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    ProgressBar(value: .constant(0.5))
  }
}
