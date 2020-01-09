//
//  EpisodeInfo.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/14.
//  Copyright © 2019 Mars. All rights reserved.
//
import UIKit
import SwiftUI
import BoxueDataKit

struct EpisodeInfo: View {
  @Binding var episode: Episode
  
  var size: CGSize
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(episode.title)
        .font(Font(UIFont.preferredFont(forTextStyle: .title3)))
        .lineLimit(2)
        .foregroundColor(Color(.label))
        .multilineTextAlignment(.leading)
        .minimumScaleFactor(0.8)
      
      Spacer()
        
      HStack {
        HStack(alignment: .center, spacing: 5) {
          Image(systemName: "calendar.circle")
            .foregroundColor(Color(.secondaryLabel))
            .font(.footnote)
          Text(episode.updatedAtStr)
            .foregroundColor(Color(.secondaryLabel))
            .font(.footnote)
        }
      
        HStack(alignment: .center, spacing: 5) {
          Image(systemName: "timer")
            .foregroundColor(Color(.secondaryLabel))
            .font(.footnote)
          Text(episode.durationText)
            .foregroundColor(Color(.secondaryLabel))
            .font(.footnote)
        }
        
        Spacer()
        
        HStack(alignment: .center, spacing: 5) {
          Text(episode.tags[0])
            .foregroundColor(.white).font(.footnote).padding([.leading, .trailing], 10)
            .frame(height: 20)
            .background(Tag(color: .orange, tr: 10, bl: 10))
          
          Text(episode.tags[1])
            .foregroundColor(.white).font(.footnote).padding([.leading, .trailing], 10)
            .frame(height: 20)
            .background(Tag(color: Color(UIColor.systemTeal), tl: 10, br: 10))
        }
      }
    }
    .padding(.top, 10)
    .padding(.leading, 10)
    .padding(.trailing, 10)
    .padding(.bottom, 10)
    .frame(maxWidth: size.width, maxHeight: size.height, alignment: .leading)
    .background(Color(.tertiarySystemBackground))
  }
}


//struct EpisodeInfo_Previews: PreviewProvider {
//    static var previews: some View {
//      EpisodeInfo(size: CGSize(width: 330, height: 70))
//    }
//}
