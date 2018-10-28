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
    @IBAction func UpLoadButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    var photoManager = PhotosManager()
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
    
    @objc func reset(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews {
            view.removeFromSuperview()
        }
    }
    
    @objc func getGrid1(){
        populateLayout()
        photoManager.getNewGrid(style:.case1)
    }
    
    @objc func getGrid2() {
        populateLayout()
        photoManager.getNewGrid(style:.case2)
    }
    
    @objc func getGrid3()  {
        populateLayout()
        photoManager.getNewGrid(style:.case3)
    }
    
    func getImage() -> UIButton{
        let buttonView = photoManager.makeButton()
        return buttonView
    }
    
    func populateLayout() {
        reset()
        
        var grid = photoManager.imagesGrid
        let top = grid[0]
        let bottom = grid[1]
        
        for _ in top.enumerated() {
            topGrid.addArrangedSubview(getImage())
            
        }
        for _ in bottom.enumerated() {
            bottomGrid.addArrangedSubview(getImage())
        }
    }
}

