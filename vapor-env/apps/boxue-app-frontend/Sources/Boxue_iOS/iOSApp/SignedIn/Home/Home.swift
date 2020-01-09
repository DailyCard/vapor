//
//  Home.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/11.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import BoxueDataKit

struct Home: View {
  @ObservedObject var viewModel: HomeViewModel
  
  var body: some View {
    NavigationView {
      Group {
        if viewModel.hasLocalData {
          ScrollView(.vertical, showsIndicators: false) {
            VStack {
              RecentUpdateRow(isSignedIn: $viewModel.isSignedIn, recentUpdate: $viewModel.homeData.recentUpdate)
                .padding(.top, 20)

              Divider()
              
              if (viewModel.isSignedIn) {
                HistoryRow(histories: viewModel.histories)
                  .padding(.top, 20)
              }
              else {
                FreeEpisodeRow(freeEpisodes: viewModel.freeEpisodes)
                  .padding(.top, 20)
              }
              
              Divider()
              
              LearningPathRow(paths: $viewModel.homeData.learningPaths)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
          }
        }
        
        if viewModel.isLoadingError {
          Text("LOADING_DATA_FAILED")
            .foregroundColor(Color(.secondaryLabel))
          
          Button(action: {
            self.viewModel.fetchHomeData()
          }) {
            Text("REFRESH")
          }
        }
        else if !viewModel.hasLocalData {
          Text("LOADING_DATA")
            .foregroundColor(Color(.secondaryLabel))
        }
      }
      .navigationBarTitle("HOME_TAB_LABEL", displayMode: .inline)
      .navigationBarItems(trailing:
        HStack(alignment: .center, spacing: 15) {
          if viewModel.isSignedIn {
            Button(action: {
              print("Go to favourite list.")
            }) {
              Image(systemName: "heart.fill")
                .foregroundColor(Color(.systemPink))
            }
            
            Button(action: {
                print("Go to watch later list.")
            }) {
              Image(systemName: "square.stack.3d.up.fill")
            }
          }
        }
      )
    }
    .background(Color(.secondarySystemBackground))
  }
}

//struct Home_Previews: PreviewProvider {
//  static var previews: some View {
//    Group {
//     Home()
//        .environment(\.colorScheme, .light)
//
//     Home()
//        .environment(\.colorScheme, .dark)
//    }
//  }
//}
