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
    
    enum layoutStyle {
        case case1, case2, case3
    }
    
    var button = UIButton()
    var imagesGrid = [[UIButton]]()
    var style:layoutStyle = .case1
    
    init() {
        imagesGrid = [[button],[button]]
    }
    
    func getNewGrid(style:layoutStyle){
        self.style = style
        switch style {
        case .case1: imagesGrid = [[button],[button,button]]
        case .case2: imagesGrid = [[button,button],[button]]
        case .case3: imagesGrid = [[button,button],[button,button]]
        }
    }
}
