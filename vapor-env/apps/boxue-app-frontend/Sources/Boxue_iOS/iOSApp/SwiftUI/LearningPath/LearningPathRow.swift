//
//  LearningPathRow.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/15.
//  Copyright © 2019 Mars. All rights reserved.
//
import UIKit
import SwiftUI
import BoxueDataKit

struct LearningPathRow: View {
  @Binding var paths: [LearningPath]
  @Environment(\.viewController) private var viewControllerHolder: UIViewController?
  
  private var viewController: UIViewController? { self.viewControllerHolder }
  
  var body: some View {
    VStack() {
      HStack() {
        Text("LEARNING_PATH_LABEL")
        .font(Font(UIFont.preferredFont(forTextStyle: .title3)))
        .bold()
        .foregroundColor(Color(.label))
        .padding(.bottom, 0)
        
        Spacer()
      }
      .padding(.leading, 15)
      .padding(.trailing, 15)
      .padding(.bottom, 0)
      
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 10) {
          Button(action: {
            self.viewControllerHolder?.present(style: .fullScreen, builder: {
              LearningPathDetail(/* pass `paths[0]` as learning path information. */)
            })
            
            self.viewController?.present(LearningPathDetailViewController(), animated: true, completion: nil)
          }) {
            AppLearningPathCard(learningPath: $paths[0])
          }
          
//          .sheet(isPresented: $showDetails) {
//
//          }
          
//          NavigationLink(
//            destination: LearningPathDetail(/* pass `paths[0]` as learning path information. */),
//            label: {
//              AppLearningPathCard(learningPath: $paths[0])
//            })
          
          NavigationLink(
            destination: LearningPathDetail(/* pass `paths[1]` as each episode information. */),
            label: {
              ServerSideLearningPathCard(learningPath: $paths[1])
            })
          
        }
        
        .padding(.leading, 15)  // This padding is added to the content
        .padding(.trailing, 15) // This padding is added to the content
        .padding(.top, 1)       // This padding is reserved for the shadow
        .padding(.bottom, 3)
      }
    }
  }
}

//struct LearningPathRow_Previews: PreviewProvider {
//  @State static var paths = Array<LearningPath>(
//    arrayLiteral: LearningPath(
//      title: "从零开始的泊学 App 开发",
//      coverUrl: "https://image.boxueio.com/boxue-app-client-path@2x.jpg",
//      summary: "泊学 App 是如何从一行代码没有到最终上线的？我们按照 Swift 语言、Sketch 设计，到实际开发的顺序，整理了泊学相关的视频。",
//      totalEpisodes: 11,
//      totalDuration: 11
//    ),
//
//    LearningPath(
//      title: "从零开始的泊学服务端开发",
//      coverUrl: "https://image.boxueio.com/boxue-app-server-side-path-v2@2x.jpg",
//      summary: "还是个服务端开发的新手？没问题！从部署泊学在服务端使用的 Docker + Laravel 环境，到 App 使用的全部 HTTP REST API 的开发，我们从头开始。",
//      totalEpisodes: 11,
//      totalDuration: 11
//    )
//  )
//  
//  static var previews: some View {
//    LearningPathRow(paths: $paths)
//  }
//}
