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
    
    enum LayoutStyle {
        case case1, case2, case3
    }
    
    var images:[UIImage]
    var style:LayoutStyle = .case1
    
    init() {
        images = [
            UIImage(named:"plus_icon")!,
            UIImage(named:"plus_icon")!,
            UIImage(named:"plus_icon")!,
            UIImage(named:"plus_icon")!
        ]
    }
    
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
