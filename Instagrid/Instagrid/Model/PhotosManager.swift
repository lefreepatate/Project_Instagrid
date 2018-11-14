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
    
    // Getting "case1" as default parameter
    var style = LayoutStyle.case1
    
    // Using a 2 model array which will call the viewController to change the view "grid"
    var imageGrid:[[UIImage]]{
        switch style {
        case .case1: return
            [
                [images[0]],
                [images[1],images[2]]
            ]
        case .case2:  return
            [
                [images[0],images[1]],
                [images[2]]
            ]
        case .case3:  return
            [
                [images[0],images[1]],
                [images[2],images[3]]
            ]
        }
    }
}
