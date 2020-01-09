//
//  EpisodeCover.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/14.
//  Copyright © 2019 Mars. All rights reserved.
//
import UIKit
import SwiftUI
import BoxueDataKit
import KingfisherSwiftUI

struct EpisodeCover: View {
  @Binding var isSignedIn: Bool
  @Binding var episode: Episode
  var size: CGSize
  
  var body: some View {
    ZStack(alignment: .leading) {
      KFImage(URL(string: episode.coverUrl)!)
        .resizable()
        .renderingMode(.original)
        .frame(width: size.width, height: size.height)
      
      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: 5) {
          Text(episode.levelText)
            .foregroundColor(Color(.systemTeal))
            .bold()
            .font(.callout)
          
          Spacer()
          
          if (episode.typeText != "") {
            Text(episode.typeText)
              .foregroundColor(.white).font(.footnote).padding([.leading, .trailing], 10)
              .frame(height: 20)
              .background(Tag(color: .green, tl: 10, tr: 10, bl: 10, br: 10))
          }
        }
        .padding(.top, 10)
        .padding([.leading, .trailing], 10)
        
        Spacer()
        
        HStack {
          if isSignedIn {
            HStack(alignment: .center, spacing: 20) {
              Image(systemName: "suit.heart")
                .foregroundColor(Color(.systemPink))
                .font(.headline)
                
              Image(systemName: "square.stack.3d.up")
                .foregroundColor(Color(.systemBlue))
                .font(.headline)
            }
          }
          
          Spacer()
          
          Image(systemName: "play.circle.fill")
            .foregroundColor(Color(.fixedSystemGray5))
            .font(.title)
            .opacity(0.8)
        }
        .padding(.bottom, 10)
        .padding([.leading, .trailing], 10)
      }
    }
    .frame(width: size.width, height: size.height)
  }
}

//struct EpisodeCover_Previews: PreviewProvider {
//    static var previews: some View {
//      EpisodeCover(size: CGSize(width: 330, height: 186))
//    }
//}
