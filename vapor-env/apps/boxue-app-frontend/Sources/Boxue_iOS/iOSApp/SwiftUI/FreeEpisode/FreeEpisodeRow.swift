//
//  FreeEpisodeRow.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/15.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueUIKit
import BoxueDataKit

struct FreeEpisodeRow: View {
  @Binding var freeEpisodes: [FreeEpisode]
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .firstTextBaseline) {
        Text("FREE_EPISODE_LABEL")
          .font(Font(UIFont.preferredFont(forTextStyle: .title3)))
          .bold()
          .foregroundColor(Color(.label))
        
        Spacer()
        
        Button(action: {}) {
          HStack(spacing: 5) {
            Text("SEE_ALL_LABEL")
              .font(.caption)
              .bold()
              .foregroundColor(Color(.link))
            Image(systemName: "chevron.right.circle.fill")
              .font(.caption)
          }
          
        }
      } // End HStack
      .padding(.leading, 15)
      .padding(.trailing, 15)
      .padding(.bottom, 0)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 10) {
          ForEach(freeEpisodes.indices, id: \.self) { index in
            NavigationLink(
              destination: EpisodePlay(/* pass `freeEpisodesentUpdate[index].episode` as each episode information. */),
              label: {
                FreeEpisodeCard(freeEpisode: self.$freeEpisodes[index], size: CGSize(width: 200, height: 113), radius: 9)
              })
          }
        }
        .padding(.leading, 15) // This padding is added to the content
        .padding(.trailing, 15)
        .padding(.bottom, 2)   // This padding is reserved for the shadow
      }
    }
  }
}



//struct RecentUpdateRow_Previews: PreviewProvider {
//
//  static var previews: some View {
//      RecentUpdateRow()
//  }
//}


