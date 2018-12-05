//
//  PhotosManager.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 19/10/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//
import UIKit
import Foundation
class PhotosManager {
   
   // Getting enum Style for below grids
   enum LayoutStyle {
      case case1, case2, case3
   }
   
   // New array with 4 images used below, and for getting the buttons
   var images = [
      UIImage(named:"plus_icon")!,
      UIImage(named:"plus_icon")!,
      UIImage(named:"plus_icon")!,
      UIImage(named:"plus_icon")!
   ]
   
   // Using a 2D array model which will be called by the viewController to change the view "grid"
   var imageGrid: [[UIImage]] {
      switch style {
      case .case1: return
         [
            [images[0]],
            [images[1], images[2]]
         ]
      case .case2: return
         [
            [images[0], images[1]],
            [images[2]]
         ]
      case .case3: return
         [
            [images[0], images[1]],
            [images[2], images[3]]
         ]
      }
   }
   // MARK: \\\ BONUS
   // Images must be loaded before sharing
   
   var ready: Bool {
      switch style {
      case .case1: return
         images[0] != UIImage(named: "plus_icon")
            && images[1] != UIImage(named: "plus_icon")
            && images[2] != UIImage(named: "plus_icon")
      case .case2: return
         images[0] != UIImage(named: "plus_icon")
            && images[1] != UIImage(named: "plus_icon")
            && images[2] != UIImage(named: "plus_icon")
      case .case3: return
         images[0] != UIImage(named: "plus_icon")
            && images[1] != UIImage(named: "plus_icon")
            && images[2] != UIImage(named: "plus_icon")
            && images[3] != UIImage(named: "plus_icon")
      }
   }
   
   // Getting "case1" as default parameter
   var style = LayoutStyle.case1
}
