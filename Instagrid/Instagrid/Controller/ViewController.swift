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

    @IBOutlet var photoGrid: [UIStackView]!
    @IBOutlet weak var topGrid:UIStackView!
    @IBOutlet weak var bottomGrid: UIStackView!
    
    var photoManager = PhotosManager()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        getGrid1()
        /*let name = Notification.Name(rawValue: "Grid")
         NotificationCenter.default.addObserver(self, selector: #selector(getGrid1), name: name, object: nil)*/
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func UpLoadButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews {
            view.removeFromSuperview()
        }
    }
    
    @objc func getGrid1(){
        photoManager.getNewGrid(style:.case1)
        populateLayout()
    }
    
    @objc func getGrid2() {
        photoManager.getNewGrid(style:.case2)
        populateLayout()
    }
    
    @objc func getGrid3()  {
        photoManager.getNewGrid(style:.case3)
        populateLayout()
    }
    
    @objc func makeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "plus_icon"), for: UIControl.State.normal)
        button.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: UIControl.State.highlighted)
        return button
    }
    
    func populateLayout() {
        reset()
        var grid = photoManager.imagesGrid
        let top = grid[0]
        let bottom = grid[1]
        
        for _ in top.enumerated() {
            topGrid.addArrangedSubview(makeButton())
        }
        
        for _ in bottom.enumerated() {
            bottomGrid.addArrangedSubview(makeButton())
        }
    }
}

