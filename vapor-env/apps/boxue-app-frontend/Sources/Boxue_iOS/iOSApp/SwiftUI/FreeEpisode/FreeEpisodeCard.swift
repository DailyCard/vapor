//
//  FreeEpisodeCard.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/10/14.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import Foundation
import BoxueDataKit

struct FreeEpisodeCard: View {
  @Binding var freeEpisode: FreeEpisode
  
  let size: CGSize
  let radius: CGFloat
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      FreeEpisodeCover(freeEpisode: $freeEpisode, size: CGSize(width: size.width, height: size.height))
      FreeEpisodeInfo(freeEpisode: $freeEpisode, size: CGSize(width: size.width, height: 50))
    }
    .cornerRadius(radius)
    .shadow(radius: 1, x: 0, y: 1)
  }
}
