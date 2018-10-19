//
//  ViewController.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 28/09/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet var photoGrid: [UIStackView]!
    @IBOutlet weak var topGrid:UIStackView!
    @IBOutlet weak var bottomGrid: UIStackView!
    @IBAction func photoButton(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        sender.setImage(#imageLiteral(resourceName: "plus_icon"), for: UIControl.State.normal)
        sender.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: UIControl.State.highlighted)
    }
    @IBAction func button1(_ sender: UIButton) {
        sender.setBackgroundImage(#imageLiteral(resourceName: "Layout 1"), for: UIControl.State.normal)
        sender.setImage(#imageLiteral(resourceName: "Layout1_over"), for: UIControl.State.selected)
        reset()
    }
    @IBAction func button2(_ sender: UIButton) {
        reset()
    }
    @IBAction func button3(_ sender: UIButton) {
        reset()
    }
 
    
    @objc func reset(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for views in subViews {
            topGrid.removeArrangedSubview(views)
            bottomGrid.removeArrangedSubview(views)
            views.removeFromSuperview()
        }
    }
    @objc func getGrid1() {
        let grid = PhotoManager()
        reset()
        grid.grid1per2()
    }
    @objc func getGrid2() {
        let grid = PhotoManager()
        reset()
        grid.grid2per1()
    }
    @objc func getGrid3()  {
        let grid = PhotoManager()
        reset()
        grid.grid2per2()
    }
}

