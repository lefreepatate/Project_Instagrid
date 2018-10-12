//
//  PhotoView.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 10/10/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class PhotoView: UIView {

    @IBOutlet private var check:UIImageView!
    enum gridStyle {
        case grid1, grid2, grid3
    }
    enum menuChoice{
        case standard, selected
    }
    var style:gridStyle = .grid1 {
        didSet {
            setView(style)
        }
    }
    private func setView(_ style: gridStyle){
        switch style {
        case .grid1:
            grid2 = []
            grid3 = []
        case .grid2:
            grid1 = []
            grid3 = []
        case .grid3:
            grid1 = []
            grid2 = []
        }
    }
    var menuStyle:menuChoice = .standard {
        didSet {
            menuView(menuStyle)
        }
    }
    private func menuView(_ style: menuChoice){
        switch style {
        case .standard:
            check.image = UIImage(named: "Selected")
            check.isHidden = true
        case .selected:
            check.image = UIImage(named: "Selected")
            check.isHidden = false
        }
    }
   

}
