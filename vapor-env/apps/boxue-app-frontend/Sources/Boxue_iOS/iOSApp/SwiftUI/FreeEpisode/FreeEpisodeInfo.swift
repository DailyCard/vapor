//
//  FreeEpisodeInfo.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/10/14.
//  Copyright © 2019 Mars. All rights reserved.
//
import SwiftUI
import Foundation
import BoxueDataKit

struct FreeEpisodeInfo: View {
  @Binding var freeEpisode: FreeEpisode
  var size: CGSize
  
  var body: some View {
    VStack(alignment: .leading, spacing: 7.0) {
      Text(freeEpisode.episode.title)
        .font(.footnote)
        .foregroundColor(Color(.label))
        .multilineTextAlignment(.leading)
        .minimumScaleFactor(0.9)
      
      HStack(alignment: .center, spacing: 5) {
        Image(systemName: "clock")
          .foregroundColor(Color(.secondaryLabel))
          .font(.footnote)
        Text(freeEpisode.episode.updatedAtStr)
          .foregroundColor(Color(.secondaryLabel))
          .font(.footnote)
        
        Spacer()
        
        Text(freeEpisode.episode.levelText)
          .foregroundColor(.blue)
          .font(.caption)
          
      }
    }
    .padding(10)
    .frame(maxWidth: size.width, maxHeight: size.height, alignment: .leading)
    .background(Color(.tertiarySystemBackground))
  }
}

