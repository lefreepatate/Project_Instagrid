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
    
    // MARK: ---------- IBOUTLET
    
    @IBOutlet var photoGrid: [UIStackView]!
    @IBOutlet weak var topGrid:UIStackView!
    @IBOutlet weak var bottomGrid: UIStackView!
    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet weak var backgroundGrid: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrayView: UIImageView!
    @IBOutlet weak var swipeUpLabel: UILabel!
    @IBOutlet weak var swipeLeftLabel: UILabel!
    
    
    // MARK: ---------- VARIABLES
    
    var photoManager = PhotosManager()
    let imagePicker = UIImagePickerController()
    private var imageTag:Int?
    let button = UIButton()
    
    // MARK: ---------- IBACTIONS
    
    @IBAction func button1(_ sender: UIButton) {
        getGrid1()
        checkSelected()
        sender.isSelected = true
    }
    @IBAction func button2(_ sender: UIButton) {
        getGrid2()
        checkSelected()
        sender.isSelected = true
    }
    @IBAction func button3(_ sender: UIButton) {
        getGrid3()
        checkSelected()
        sender.isSelected = true
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isHighlighted = !sender.isHighlighted
    }
    
    // MARK: ---------- FUNCTIONS
    
    // Getting grid case 1 from model by default
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(addSwipeGesture), name: UIDevice.orientationDidChangeNotification, object: nil)
        imagePicker.delegate = self
        applyGridDesign(grid: backgroundView)
        getGrid1()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
        backgroundView.addGestureRecognizer(swipe)
        
    }
    
    // Functions calling the pickerDelegate getting new images
    @objc func photofromLibrary( _ sender: UIButton) {
        imageTag = sender.tag
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Reset function removing the actual views in the grid
    @objc func reset(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews { view.removeFromSuperview() }
    }
    
    // Function making new buttons to being calling after for the grids
    func makeButton(image:UIImage,tag:Int) -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        button.tag = tag
        button.addTarget(self, action: #selector(photofromLibrary(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 2
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(image, for: .normal)
        button.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: .highlighted)
        
        return button
    }
    
    // Getting designs style for the Grid
    func applyGridDesign(grid:UIView) {
        grid.layer.shadowColor = UIColor.black.cgColor
        grid.layer.shadowRadius = 4
        grid.layer.shadowOpacity = 0.5
        grid.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    // Function replacing the current views by model views containing an image "+"
    func populateLayout() {
        reset()
        
        var grid = photoManager.imageGrid
        let top = grid[0]
        let bottom = grid[1]
        var count = 0
        
        for image in top.enumerated() {
            topGrid.addArrangedSubview(makeButton(image: image.element,tag:count))
            count += 1
        }
        for image in bottom.enumerated() {
            bottomGrid.addArrangedSubview(makeButton(image: image.element,tag:count))
            count += 1
        }
    }
    
    //Function checking which button is selected on the menu bar
    func checkSelected(){
        for button in menuButtons{ (button as UIButton).isSelected = false }
    }
    
    // Function getting the grid case 1 from the model
    @objc func getGrid1(){
        photoManager.style = .case1
        populateLayout()
    }
    
    // Function getting the grid case 2 from the model
    @objc func getGrid2() {
        photoManager.style = .case2
        populateLayout()
    }
    
    // Function getting the grid case 3 from the model
    @objc func getGrid3()  {
        photoManager.style = .case3
        populateLayout()
    }
    
    //Function getting the new image and replacing by the default one
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let newImage = info[.originalImage] as? UIImage else {return}
        
        photoManager.images[imageTag!] = newImage
        populateLayout()
        
        dismiss(animated: true, completion: nil)
    }
    
    // Function calling gesture reconizer
    @objc func addSwipeGesture(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
        
        if UIDevice.current.orientation.isPortrait {
            swipeUp.direction = .up
            print("portrait\n")
        } else {
            swipeLeft.direction = .left
            print("paysage\n")
        }
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            switch gesture.direction {
            case .up:
                upAnimation()
            case .left:
                leftAnimation()
            default:
                break
            }
        }
    }
    
    // Animations for each swipe state
    private func upAnimation() {
        print("animating up")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5, options:.curveEaseInOut, animations: {
            self.backgroundGrid.transform = CGAffineTransform(translationX:0 , y: 50)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options:.curveEaseInOut, animations: {
                self.backgroundGrid.transform = CGAffineTransform(translationX:0 , y: -self.view.frame.height)
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: 150)
                self.swipeUpLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: 10)
                self.swipeUpLabel.text = "GREAT !"
                self.swipeUpLabel.textColor = #colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)
                self.arrayView.alpha = 0
                self.arrayView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
        }
    }
    
    private func leftAnimation() {
        print("animating left")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5, options:.curveEaseInOut, animations: {
            self.backgroundGrid.transform = CGAffineTransform(translationX: 50 , y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options:.curveEaseInOut, animations:  {
                self.backgroundGrid.transform = CGAffineTransform(translationX:-self.view.frame.width , y: 0)
                self.swipeLeftLabel.text = "GREAT !"
                self.swipeLeftLabel.textColor = #colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: 150)
                self.swipeLeftLabel.transform = self.swipeLeftLabel.transform.translatedBy(x: 260, y: 0)
                self.arrayView.alpha = 0
                self.arrayView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            })
        }
    }
}

