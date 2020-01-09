//
//  NavigationAction.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/17.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public enum NavigationAction<ViewModelStatus>: Equatable
  where ViewModelStatus: Equatable {
  case present(viewStatus: ViewModelStatus)
  case presented(viewStatus: ViewModelStatus)
}
