//
//  HistoryInfo.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/15.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueDataKit

struct HistoryInfo: View {
  @Binding var history: WatchingHistory
  var size: CGSize
  
  var body: some View {
    VStack(alignment: .leading, spacing: 7.0) {
      Text(history.episode.title)
        .font(Font(UIFont.preferredFont(forTextStyle: .footnote)))
        .foregroundColor(Color(.label))
        .multilineTextAlignment(.leading)
        .minimumScaleFactor(0.9)
      
      HStack(alignment: .center, spacing: 5) {
        Image(systemName: "clock")
          .foregroundColor(Color(.secondaryLabel))
          .font(.footnote)
        Text(history.episode.updatedAtStr)
          .foregroundColor(Color(.secondaryLabel))
          .font(.footnote)
        
        Spacer()
        
        Text(history.episode.levelText)
          .foregroundColor(.blue)
          .font(.caption)
          
      }
    }
    .padding(10)
    .frame(maxWidth: size.width, maxHeight: size.height, alignment: .leading)
    .background(Color(.tertiarySystemBackground))
  }
}

//struct HistoryInfo_Previews: PreviewProvider {
//  static var previews: some View {
//      HistoryInfo(size: CGSize(width: 220, height: 70))
//  }
//}
