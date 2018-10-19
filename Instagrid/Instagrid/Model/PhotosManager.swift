//
//  PhotosManager.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 19/10/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit
class PhotoManager:ViewController {
    
    func grid1per2(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews{
            topGrid.addArrangedSubview(view)
            bottomGrid.addArrangedSubview(view)
            bottomGrid.addArrangedSubview(view)
        }
    }
    func grid2per1(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews{
            topGrid.addArrangedSubview(view)
            topGrid.addArrangedSubview(view)
            bottomGrid.addArrangedSubview(view)
        }
    }
    func grid2per2(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews{
            topGrid.addArrangedSubview(view)
            topGrid.addArrangedSubview(view)
            bottomGrid.addArrangedSubview(view)
            bottomGrid.addArrangedSubview(view)
        }
    }
}
