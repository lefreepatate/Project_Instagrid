//
//  PhotoView.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 10/10/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Foundation
class PhotoView: UIView {

    @IBOutlet private var check:UIImageView!

    enum menuChoice{
        case standard, selected
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
