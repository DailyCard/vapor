//
//  FreeEpisodeCover.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/10/14.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation

import SwiftUI
import BoxueDataKit
import KingfisherSwiftUI

struct FreeEpisodeCover: View {
  @Binding var freeEpisode: FreeEpisode
  var size: CGSize
  
  var body: some View {
    ZStack(alignment: .leading) {
      KFImage(URL(string: freeEpisode.episode.coverUrl)!)
        .renderingMode(.original)
        .resizable()
        .frame(width: size.width, height: size.height)
      
      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: 5) {
          Spacer()
          
          Text(freeEpisode.episode.typeText)
            .foregroundColor(.white).font(.footnote).padding([.leading, .trailing], 10)
            .frame(height: 20)
            .background(Tag(color: .green, tl: 10, tr: 10, bl: 10, br: 10))
            .offset(x: -10, y: 10)
        }
        
        Spacer()
        
        HStack(alignment: .center, spacing: 5) {
          Spacer()
          
          Text(freeEpisode.episode.durationText)
            .foregroundColor(Color(.systemTeal))
            .font(.footnote)
        }
        .offset(x: -10, y: -10)
      }
    }
    .frame(width: size.width, height: size.height)
  }
}

struct FreeEpisodeCover_Previews: PreviewProvider {
//  static func fakeFreeEpisode() -> FreeEpisode {
//    let json = """
//    
//    """
//  }
  static var previews: some View {
    Group {
      Text("Hello")
    }
  }
}

