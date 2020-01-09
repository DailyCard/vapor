//
//  HistoryCover.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/15.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueDataKit
import KingfisherSwiftUI

struct HistoryCover: View {
  @Binding var history: WatchingHistory
  var size: CGSize
  
  var body: some View {
    ZStack(alignment: .leading) {
      KFImage(URL(string: history.episode.coverUrl)!)
        .renderingMode(.original)
        .resizable()
        .frame(width: size.width, height: size.height)
      
      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: 5) {
          Spacer()
          
          if (history.episode.typeText != "") {
            Text(history.episode.typeText)
              .foregroundColor(.white).font(.footnote).padding([.leading, .trailing], 10)
              .frame(height: 20)
              .background(Tag(color: .green, tl: 10, tr: 10, bl: 10, br: 10))
              .offset(x: -10, y: 10)
          }
        }
        
        Spacer()
        
        HStack {
          HStack(alignment: .center, spacing: 5) {
            Image(systemName: "timer")
              .foregroundColor(Color(.systemTeal))
              .font(.footnote)
              .opacity(0.8)
            Text("\(history.progressText) / \(history.episode.durationText)")
              .foregroundColor(Color(.systemTeal))
              .font(.footnote)
          }
          .offset(x: 10, y: 0)
        }
        
        ProgressBar(height: 3, value: .constant(0.6))
          .frame(height: 3)
          .padding(.leading, 10)
          .padding(.trailing, 10)
          .padding(.bottom, 6)
      }
    }
    .frame(width: size.width, height: size.height)
  }
}

//struct HistoryCover_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryCover(size: CGSize(width: 220, height: 124))
//    }
//}
