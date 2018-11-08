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
    @IBOutlet var menuButtons: [UIStackView]!
    
    var photoManager = PhotosManager()
    let imagePicker = UIImagePickerController()
    private var imageTag:Int?
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGrid1()
    }
    @objc func photofromLibrary( _ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let newImage = info[.originalImage] as? UIImage else {return}
        
        imageTag = button.tag
        photoManager.images.insert(newImage, at: imageTag!)
        button.tag += 1
        if button.tag > 3 {button.tag = 0}
        
        populateLayout()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func button1(_ sender: UIButton) {
        getGrid1()
        sender.setBackgroundImage(UIImage(named:"Layout1")!, for: .normal)
        sender.setBackgroundImage(UIImage(named:"Layout1_over")!, for:.selected)
        sender.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @IBAction func button2(_ sender: UIButton) {
        getGrid2()
        sender.setBackgroundImage(UIImage(named:"Layout2")!, for: .normal)
        sender.setBackgroundImage(UIImage(named:"Layout2_over")!, for: .selected)
        sender.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @IBAction func button3(_ sender: UIButton) {
        getGrid3()
        sender.setBackgroundImage(UIImage(named:"Layout3")!, for: .normal)
        sender.setBackgroundImage(UIImage(named:"Layout3_over")!, for: .selected)
        sender.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isHighlighted = !sender.isHighlighted
    }
    
    @objc func reset(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews {
            view.removeFromSuperview()
        }
    }
    
    @objc func getGrid1(){
        photoManager.style = .case1
        populateLayout()
    }
    
    @objc func getGrid2() {
        photoManager.style = .case2
        populateLayout()
    }
    
    @objc func getGrid3()  {
        photoManager.style = .case3
        populateLayout()
    }
    
    func makeButton(image:UIImage) -> UIButton {
        
        let button = UIButton()
        
        button.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        button.setImage(image, for: .normal)
        button.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: .highlighted)
        button.contentMode = .scaleAspectFit
        button.tag = 0
        button.addTarget(self, action: #selector(photofromLibrary(_:)), for: .touchUpInside)
        
        return button
    }
    
    func populateLayout() {
        reset()
        
        var grid = photoManager.imageGrid
        let top = grid[0]
        let bottom = grid[1]
        
        for image in top.enumerated() {
            topGrid.addArrangedSubview(makeButton(image: image.element))
        }
        for image in bottom.enumerated() {
            bottomGrid.addArrangedSubview(makeButton(image: image.element))
        }
    }
}

