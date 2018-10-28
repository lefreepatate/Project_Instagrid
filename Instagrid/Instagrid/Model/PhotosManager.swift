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
    
    var button = UIButton()
    var imagesGrid = [[UIButton]]()
    init() {
        imagesGrid = [[button,button],[button,button]]
    }

    var style:layoutStyle = .case1
    enum layoutStyle {
        case case1, case2, case3
    }

    
    func makeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "plus_icon"), for: UIControl.State.normal)
        button.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: UIControl.State.highlighted)
        return button
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
