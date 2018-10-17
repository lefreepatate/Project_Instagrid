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
    var icon = UIImageView() {
        didSet {
            icon.image = #imageLiteral(resourceName: "plus_icon")
        }
    }
    @IBOutlet weak var PhotoGrid: UIStackView!
    @IBOutlet weak var topGrid:UIStackView!
    @IBOutlet weak var bottomGrid: UIStackView!
    var button:UIButton! {
        didSet {
            icon.image = #imageLiteral(resourceName: "plus_icon")
            button.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
            icon.isHidden = false
            button.isHidden = false
        }
    }
    
    @IBAction func button1(_ sender: UIButton) {
        getGrid1()
    }
    @IBAction func button2(_ sender: UIButton) {
        getGrid2()
    }
    @IBAction func button3(_ sender: UIButton) {
        getGrid3()
    }
    @objc func reset(){
        let grid = [UIStackView]()
        for views in grid{
            topGrid.removeArrangedSubview(views)
            bottomGrid.removeArrangedSubview(views)
        }
    }
     @objc func getGrid1() {
        reset()
        topGrid.addArrangedSubview(button)
        bottomGrid.addArrangedSubview(button)
        bottomGrid.addArrangedSubview(button)
    }
    @objc func getGrid2() {
        reset()
        topGrid.addArrangedSubview(button)
        topGrid.addArrangedSubview(button)
        bottomGrid.addArrangedSubview(button)
    }
    @objc func getGrid3() {
        reset()
        topGrid.addArrangedSubview(button)
        topGrid.addArrangedSubview(button)
        bottomGrid.addArrangedSubview(button)
        bottomGrid.addArrangedSubview(button)
    }

}

