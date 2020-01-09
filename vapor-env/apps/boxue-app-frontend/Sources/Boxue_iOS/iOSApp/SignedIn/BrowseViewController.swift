//
//  BrowseViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/14.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import BoxueUIKit
import BoxueDataKit
import BXAnimatedTabBar

public class BrowseViewController: NiblessViewController {
  /// - Properties
  let tabVC = BXAnimatedTabBarController()
  var homeVC: HomeViewController!
  var searchVC: SearchViewController!
  var seriesVC: SeriesViewController!
  var blackboardVC: BlackboardViewController!
  var accountVC: AccountViewController!
  
  /// - Initializers
  init(
    homeVC: HomeViewController,
    searchVC: SearchViewController,
    seriesVC: SeriesViewController,
    blackboardVC: BlackboardViewController,
    accountVC: AccountViewController) {
    
    self.homeVC = homeVC
    self.searchVC = searchVC
    self.seriesVC = seriesVC
    self.blackboardVC = blackboardVC
    self.accountVC = accountVC
    
    super.init()
  }
  
  /// - Methods
  public override func loadView() {
    tabVC.viewControllers = [homeVC, searchVC, seriesVC, blackboardVC, accountVC]
    tabVC.selectedIndex = 0
    
    self.view = UIView()
    addFullScreen(childViewController: tabVC)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.tealBlue
  }
}
