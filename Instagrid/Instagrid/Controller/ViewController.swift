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
        setGrid1()
        resetSelectedButtons()
        sender.isSelected = true
    }
    
    @IBAction func button2(_ sender: UIButton) {
        setGrid2()
        resetSelectedButtons()
        sender.isSelected = true
    }
    
    @IBAction func button3(_ sender: UIButton) {
        setGrid3()
        resetSelectedButtons()
        sender.isSelected = true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isHighlighted = !sender.isHighlighted
    }
    
    // MARK: ---------- FUNCTIONS
    
    // Getting grid case 1 from model by default
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        applyGridDesign(grid: view)
        setGrid1()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator:
        UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        addSwipeGesture()
    }
    
    // Reset function removing the actual views in the grid
    @objc func reset(){
        let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
        for view in subViews {
            view.removeFromSuperview()
        }
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
        
        for image in top {
            topGrid.addArrangedSubview(makeButton(image: image,tag:count))
            count += 1
        }
        for image in bottom {
            bottomGrid.addArrangedSubview(makeButton(image: image,tag:count))
            count += 1
        }
    }
    
    //Function checking and reset selected buttons while one new is selected
    func resetSelectedButtons(){
        for button in menuButtons{
            (button as UIButton).isSelected = false
        }
    }
    
    // Function setting the grid case 1 from the model
    @objc func setGrid1(){
        photoManager.style = .case1
        populateLayout()
    }
    
    // Function setting the grid case 2 from the model
    @objc func setGrid2() {
        photoManager.style = .case2
        populateLayout()
    }
    
    // Function setting the grid case 3 from the model
    @objc func setGrid3()  {
        photoManager.style = .case3
        populateLayout()
    }
    
    // Functions calling the pickerDelegate getting new images
    @objc func photofromLibrary( _ sender: UIButton) {
        
        imageTag = sender.tag
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Function getting the new image and replacing by the default one
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let newImage = info[.originalImage] as? UIImage else {return}
        
        photoManager.images[imageTag!] = newImage
        populateLayout()
        
        dismiss(animated: true, completion: nil)
    }
    
    // Function checking the device orientation and giving a swipe according to
    @objc func addSwipeGesture(){
        let sender = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        
        if UIDevice.current.orientation.isPortrait {
            sender.direction = .up
            print("addswipe up")
        } else if UIDevice.current.orientation.isLandscape{
            sender.direction = .left
            print("addswipe left")
        }
        view.addGestureRecognizer(sender)
    }
    
    // Function kepping avaible the swipe gesture
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        if gesture.state == .ended /* && photoManager.images[imageTag!] != UIImage(named:"plus_icon")!*/ {
            switch gesture.direction {
            case .up:
                if UIDevice.current.orientation.isPortrait {
                    print("swipe up")
                    upAnimation()
                }
            case .left:
                if UIDevice.current.orientation.isLandscape {
                    print("swipe left")
                    leftAnimation()
                }
            default:
                break
            }
        } else {
            self.swipeUpLabel.text = "Upload Photos to share ! "
        }
    }
    
    // Animations for each swipe state
    private func upAnimation() {
        print("animating up")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5,
                       options:.curveEaseInOut, animations: {
                        self.backgroundGrid.transform = CGAffineTransform(translationX:0 , y: 50)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0,
                           options:.curveEaseInOut, animations: {
                            self.backgroundGrid.transform = CGAffineTransform(translationX:0 , y: -self.view.frame.height)
                            self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: 150)
                            self.swipeUpLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: 10)
                            self.swipeUpLabel.text = "GREAT !"
                            self.swipeUpLabel.textColor = #colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)
                            self.arrayView.alpha = 0
                            self.arrayView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
        }
        shareImage()
    }
    
    private func leftAnimation() {
        
        print("animating left")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5,
                       options:.curveEaseInOut, animations: {
                        self.backgroundGrid.transform = CGAffineTransform(translationX: 50 , y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity:
                0, options:.curveEaseInOut, animations:  {
                    self.backgroundGrid.transform = CGAffineTransform(translationX:-self.view.frame.width , y: 0)
                    self.swipeLeftLabel.text = "GREAT !"
                    self.swipeLeftLabel.textColor = #colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)
                    self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: 150)
                    self.swipeLeftLabel.transform = self.swipeLeftLabel.transform.translatedBy(x: 260, y: 0)
                    self.arrayView.alpha = 0
                    self.arrayView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            })
        }
        shareImage()
    }
    
    // Function sharing image
    func shareImage() {
        let imageToShare = backgroundGrid.asImage()
        let activityController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil,completed, _, error)
            in
            if completed {
                print("great")
            } else {
                print("oh shit!")
            }
        }
        present(activityController, animated: true){
            print("presented")
        }
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
