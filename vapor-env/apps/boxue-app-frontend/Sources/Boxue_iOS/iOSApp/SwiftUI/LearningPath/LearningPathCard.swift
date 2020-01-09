//
//  LearningPathCard.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/15.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueDataKit
import KingfisherSwiftUI

struct AppLearningPathCard: View {
  @Binding var learningPath: LearningPath
  
  var body: some View {
    LearningPathCard(learningPath: $learningPath, titleColor: .black, descriptionColor: .darkGray)
  }
}

struct ServerSideLearningPathCard: View {
  @Binding var learningPath: LearningPath
  
  var body: some View {
    LearningPathCard(learningPath: $learningPath, titleColor: .white, descriptionColor: .lightGray)
  }
}

struct LearningPathCard: View {
  @Binding var learningPath: LearningPath
  let titleColor: UIColor
  let descriptionColor: UIColor
  
  var body: some View {
    ZStack(alignment: .center) {
      KFImage(URL(string: self.learningPath.coverUrl)!)
        .renderingMode(.original)
        .resizable()
        .frame(width: 330, height: 439)
      
      VStack(alignment: .center, spacing: 15) {
        Spacer()
        Text(self.learningPath.title)
          .font(Font(UIFont.preferredFont(forTextStyle: .title2)))
          .bold()
          .multilineTextAlignment(.center)
          .foregroundColor(Color(self.titleColor))
          .padding([.leading, .trailing], 80)
        
        Text(self.learningPath.summary)
          .font(Font(UIFont.preferredFont(forTextStyle: .caption1)))
          .multilineTextAlignment(.leading)
          .foregroundColor(Color(self.descriptionColor))
          .padding([.leading, .trailing], 50)
      }
      .padding(.bottom, 20)
    }
    .frame(
      width: 330,
      height: 439)
    .cornerRadius(15)
    .shadow(radius: 2, x: 0, y: 1)
  }
}

//struct LearningPathCard_Previews: PreviewProvider {
//  @State static var path = LearningPath(
//    title: "从零开始的泊学 App 开发",
//    coverUrl: "https://image.boxueio.com/boxue-app-client-path@2x.jpg",
//    summary: "泊学 App 是如何从一行代码没有到最终上线的？我们按照 Swift 语言、Sketch 设计，到实际开发的顺序，整理了泊学相关的视频。",
//    totalEpisodes: 10,
//    totalDuration: 10)
//  
//  static var previews: some View {
//    ServerSideLearningPathCard(learningPath: $path)
//  }
//}
