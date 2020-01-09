//
//  EpisodePlayViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/10/16.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import Foundation
import BoxueUIKit
import BoxueDataKit
import BXAnimatedTabBar

public class EpisodePlayViewController: NiblessViewController {
  let hostVC: UIHostingController<EpisodePlay>
  
  let presenter = Presenter()
  let dimisser = Dismisser()
  
  // MARK: Methods
  public override init() {
    self.hostVC = UIHostingController<EpisodePlay>(rootView: EpisodePlay())
    super.init()
  }
  
  public override func loadView() {
    self.view = UIView()
    addFullScreen(childViewController: hostVC)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.tealBlue
  }
}
