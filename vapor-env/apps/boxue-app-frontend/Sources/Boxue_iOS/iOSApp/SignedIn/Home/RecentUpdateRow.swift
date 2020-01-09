//
//  HomeRow.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/12.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueUIKit
import BoxueDataKit

struct RecentUpdateRow: View {
  @Binding var isSignedIn: Bool
  @Binding var recentUpdate: [RecentUpdate]
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .firstTextBaseline) {
        Text("RECENT_UPDATE_LABEL")
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
          /* The following code doesn't work for the current version of SwiftUI. Maybe fixed later.
          ForEach($recentUpdate) {
            (elem: Binding<RecentUpdate>) -> EpisodeCard in
            EpisodeCard(episode: elem, size: CGSize(width: 330, height: 186), radius: 12)
          }
          */
          
          // The workaround for the above code.
          ForEach(recentUpdate.indices, id: \.self) { index in
            NavigationLink(
              destination: EpisodePlay(/* pass `recentUpdate[index].episode` as each episode information. */),
              label: {
                EpisodeCard(
                  isSignedIn: self.$isSignedIn,
                  episode: self.$recentUpdate[index].episode,
                  size: CGSize(width: 330, height: 186), radius: 12)
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
