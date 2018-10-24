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
        let name = Notification.Name(rawValue: "Grid")
        NotificationCenter.default.addObserver(self, selector: #selector(getGrid1), name: name, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var grid = PhotosManager.Style.layout1per2
    @IBOutlet var photoGrid: [UIStackView]!
    @IBOutlet weak var topGrid:UIStackView!
    @IBOutlet weak var bottomGrid: UIStackView!
    @IBAction func photoButton(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        sender.setImage(#imageLiteral(resourceName: "plus_icon"), for: UIControl.State.normal)
        sender.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: UIControl.State.highlighted)
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
    @IBOutlet weak var layoutLabel: UILabel!
    
    var identifyButton = 0
    func getUniqueButton(button:UIButton) -> Int {
        identifyButton += 1
        return identifyButton
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        _ = getUniqueButton(button: button)
        button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "plus_icon"), for: UIControl.State.normal)
        button.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: UIControl.State.highlighted)
        return button
    }
    
    @objc func reset(){
        identifyButton = 0
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews {
            view.removeFromSuperview()
        }
    }
    
    func countImages() {
         layoutLabel.text = "\(grid) + \(identifyButton)"
    }
    
    @objc func getGrid1(){
        reset()
        grid = PhotosManager.Style.layout1per2
        countImages()
    }
    
    @objc func getGrid2() {
        reset()
        grid = PhotosManager.Style.layout2per1
        countImages()
    }
    
    @objc func getGrid3()  {
        reset()
        grid = PhotosManager.Style.layout2per2
        countImages()
    }
}

