//
//  PhotosManager.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 19/10/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
class PhotosManager {
    
    enum Style {
        case layout1per2, layout2per1, layout2per2
    }
    var button = ViewController().makeButton()
    func layoutGrid(_ style: Style){
        switch style {
        case .layout1per2: return case1() //[[button:0],[button:1,button:2]]
        case .layout2per1: return case2()//[[button:0,button:1],[button:2]]
        case .layout2per2: return case3()//[[button:0,button:1],[button:2,button:3]]
        }
    }
    func refresh(){
        layoutGrid(Style.layout1per2)
        let name = Notification.Name(rawValue:"Grid")
        let notification = Notification(name:name)
        NotificationCenter.default.post(notification)
    }
    func case1() {
        var table = [[button]]
        for _ in table {
            table.insert([button], at:0)
            table.insert([button,button], at:1)
        }
    }
    func case2() {
        var table = [[button]]
        for _ in table {
            table.insert([button,button], at:0)
            table.insert([button], at:1)
        }
    }
    func case3() {
        var table = [[button]]
        for _ in table {
            table.insert([button,button], at:0)
            table.insert([button,button], at:1)
        }
    }

    
}

/* func grid1per2(){
 let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
 for view in subViews{
 
 }
 }
 func grid2per1(){
 let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
 for view in subViews{
 
 }
 }
 func grid2per2(){
 let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
 for view in subViews{
 }
 }*/
