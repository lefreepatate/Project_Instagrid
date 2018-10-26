//
//  ViewController.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 28/09/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        /*let name = Notification.Name(rawValue: "Grid")
         NotificationCenter.default.addObserver(self, selector: #selector(getGrid1), name: name, object: nil)*/
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet var photoGrid: [UIStackView]!
    @IBOutlet weak var topGrid:UIStackView!
    @IBOutlet weak var bottomGrid: UIStackView!
    @IBOutlet weak var tapButton: UILabel!
    @IBAction func UpLoadButton(_ sender: UIButton) {
        _ = makeButton()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func button1(_ sender: UIButton) {
        getGrid1()
    }
    
    @IBAction func button2(_ sender: UIButton) {
        getGrid2()
    }
    
    @IBAction func button3(_ sender: UIButton) {
        getGrid3()
    }
    
    var touchCount = 0
    
    lazy var button = makeButton()
    
    var identifyButton = 0
    
    func getUniqueButton(button:UIButton) -> Int {
        identifyButton += 1
        if button.state == .highlighted {
            touchCount += 1
        }
        tapButton.text = "Number of buttons: \(identifyButton)\nButton touched: \(touchCount)"
        return identifyButton + touchCount
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "plus_icon"), for: UIControl.State.normal)
        button.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: UIControl.State.highlighted)
        _ = getUniqueButton(button: button)
        return button
    }
    
    @objc func reset(){
        identifyButton = 0
        touchCount = 0
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews {
            view.removeFromSuperview()
        }
    }
    
    @objc func getGrid1(){
        reset()
        let view = makeButton
        topGrid.addArrangedSubview(view())
        bottomGrid.addArrangedSubview(view())
        bottomGrid.addArrangedSubview(view())
    }
    
    @objc func getGrid2() {
        reset()
        let view = makeButton
        topGrid.addArrangedSubview(view())
        topGrid.addArrangedSubview(view())
        bottomGrid.addArrangedSubview(view())
    }
    
    @objc func getGrid3()  {
        reset()
        let view = makeButton
        topGrid.addArrangedSubview(view())
        topGrid.addArrangedSubview(view())
        bottomGrid.addArrangedSubview(view())
        bottomGrid.addArrangedSubview(view())
    }
}

