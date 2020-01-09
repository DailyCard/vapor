//
//  HistoryCard.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/15.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueDataKit

struct HistoryCard: View {
  @Binding var history: WatchingHistory
  
  let size: CGSize
  let radius: CGFloat
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HistoryCover(history: $history, size: CGSize(width: size.width, height: size.height))
      HistoryInfo(history: $history, size: CGSize(width: size.width, height: 50))
    }
    .cornerRadius(radius)
    .shadow(radius: 1, x: 0, y: 1)
  }
}

//struct HistoryCard_Previews: PreviewProvider {
//  static var previews: some View {
//    HistoryCard(size: CGSize(width: 220, height: 124), radius: 9)
//  }
//}
