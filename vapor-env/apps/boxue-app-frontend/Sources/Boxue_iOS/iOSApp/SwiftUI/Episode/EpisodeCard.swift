//
//  EpisodeCard.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/14.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueDataKit

struct EpisodeCard: View {
  @Binding var isSignedIn: Bool
  @Binding var episode: Episode
  
  let size: CGSize
  let radius: CGFloat
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      EpisodeCover(isSignedIn: $isSignedIn, episode: $episode, size: CGSize(width: size.width, height: size.height))
      EpisodeInfo(episode: $episode, size: CGSize(width: size.width, height: 70))
    }
    .cornerRadius(radius)
    .shadow(radius: 1, x: 0, y: 1)
  }
}

//struct EpisodeCard_Previews: PreviewProvider {
//    static var previews: some View {
//      EpisodeCard(size: CGSize(width: 330, height: 186), radius: 12)
//    }
//}
