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
   
   // MARK: \\\ IBOUTLET
   
   @IBOutlet var photoGrid: [UIStackView]!
   @IBOutlet weak var topGrid: UIStackView!
   @IBOutlet weak var bottomGrid: UIStackView!
   @IBOutlet var menuButtons: [UIButton]!
   @IBOutlet weak var backgroundGrid: UIView!
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var arrayView: UIImageView!
   @IBOutlet weak var swipeUpLabel: UILabel!
   @IBOutlet weak var swipeLeftLabel: UILabel!
   
   // MARK: \\\ VARIABLES
   
   var photoManager = PhotosManager()
   let imagePicker = UIImagePickerController()
   private var imageTag: Int?
   
   // MARK: \\\ IBACTIONS
   
   // Menu buttons setting the grid views for upload
   @IBAction func button1(_ sender: UIButton) {
      setGrid1()
      resetSelectedButtons()
      sender.isSelected = false
   }
   
   @IBAction func button2(_ sender: UIButton) {
      setGrid2()
      resetSelectedButtons()
      sender.isSelected = false
   }
   
   @IBAction func button3(_ sender: UIButton) {
      setGrid3()
      resetSelectedButtons()
      sender.isSelected = false
   }
   
   @IBAction func buttonPressed(_ sender: UIButton) {
      sender.isSelected = !sender.isSelected
   }
   
   // MARK: \\\ FUNCTIONS
   
   // Getting grid case 1 from model by default
   override func viewDidLoad() {
      super.viewDidLoad()
      applyGridDesign(grid: backgroundGrid)
      setGrid1()
   }
   
   // Function checking iPhone's orientation
   override func viewWillTransition(to size: CGSize, with coordinator:
      UIViewControllerTransitionCoordinator) {
      addSwipeGesture()
      super.viewWillTransition(to: size, with: coordinator)
   }
   
   // Function allowing addSwipeGeture to the view
   override func viewDidAppear(_ animated: Bool) {
      addSwipeGesture()
      super.viewDidAppear(animated)
   }
   
   //Function checking and reset selected buttons while one new is selected
   func resetSelectedButtons() {
      for button in menuButtons {
         (button as UIButton).isSelected = false
      }
   }
   
   // Reset function removing the actual views in the grid
   @objc func reset() {
      let subViews = topGrid.arrangedSubviews + bottomGrid.arrangedSubviews
      for view in subViews {
         view.removeFromSuperview()
      }
   }
   
   // Function making new buttons to being calling after for the grids
   func makeButton(image: UIImage, tag: Int) -> UIButton {
      
      let button = UIButton()
      
      button.backgroundColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
      button.tag = tag
      button.addTarget(self, action: #selector(photofromLibrary(_:)), for: .touchUpInside)
      button.imageView?.layer.cornerRadius = 2
      button.layer.cornerRadius = 2
      button.imageView?.contentMode = .scaleAspectFill
      button.setImage(image, for: .normal)
      button.setImage(#imageLiteral(resourceName: "plus_icon_over"), for: .highlighted)
      
      return button
   }
   
   // Getting designs style for the backgroundGrid
   func applyGridDesign(grid: UIView) {
      
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
         topGrid.addArrangedSubview(makeButton(image: image, tag: count))
         count += 1
      }
      for image in bottom {
         bottomGrid.addArrangedSubview(makeButton(image: image, tag: count))
         count += 1
      }
   }
   
   // Function setting the grid case 1 from the model
   @objc func setGrid1() {
      photoManager.style = .case1
      populateLayout()
   }
   
   // Function setting the grid case 2 from the model
   @objc func setGrid2() {
      photoManager.style = .case2
      populateLayout()
   }
   
   // Function setting the grid case 3 from the model
   @objc func setGrid3() {
      photoManager.style = .case3
      populateLayout()
   }
   
   // Functions calling the pickerDelegate getting new images
   @objc func photofromLibrary(_ sender: UIButton) {
      imageTag = sender.tag
      imagePicker.allowsEditing = false
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = self
      imagePicker.modalPresentationStyle = .popover
      present(imagePicker, animated: true, completion: nil)
   }
   
   //Function getting the new image and replacing by the default one
   @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
      info: [UIImagePickerController.InfoKey : Any]) {
      
      guard let newImage = info[.originalImage] as? UIImage else { return }
      imagePicker.modalPresentationStyle = .popover
      photoManager.images[imageTag!] = newImage
      populateLayout()
      
      dismiss(animated: true, completion: nil)
   }
   
   // Function checking the device orientation and giving a swipe according to
   @objc func addSwipeGesture(){
      let sender = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
      removeRecognizer()
      arrayAnimation()
      if UIDevice.current.orientation.isPortrait {
         sender.direction = .up
      } else if UIDevice.current.orientation.isLandscape {
         sender.direction = .left
      }
      view.addGestureRecognizer(sender)
   }
   
   // Function removing gesturerecognizer
   func removeRecognizer(){
      if let reconizers =  view.gestureRecognizers {
         for gesture in reconizers {
            view.removeGestureRecognizer(gesture)
         }
      }
   }
   
   // Function kepping avaible the swipe gesture
   @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
      if photoManager.ready == false  {
         self.swipeUpLabel.text = "Upload Photos to share !"
         self.swipeLeftLabel.text = "Upload Photos to share !"
      } else if  gesture.state == .ended  {
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
   
   // Array animation
   private func arrayAnimation(){
      if photoManager.ready == true {
         self.swipeUpLabel.text = "Swipe up to share"
         self.swipeLeftLabel.text = "Swipe left to share"
         if UIDevice.current.orientation.isPortrait {
            UIView.animate(withDuration: 0.5, animations: {
               self.arrayView.transform = CGAffineTransform(translationX: 0, y: -10)
            }){ (_) in
               UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options:[.autoreverse, .repeat],
                                       animations: {
                                          self.arrayView.transform = CGAffineTransform(translationX: 0, y: 0)
               })
            }
         } else  if UIDevice.current.orientation.isLandscape {
            UIView.animate(withDuration: 0.5, animations: {
               self.arrayView.transform = CGAffineTransform(translationX: -10, y: 0)
            }){ (_) in
               UIView.animateKeyframes(withDuration: 0.5, delay: 0.0,
                                       options:[.autoreverse, .repeat], animations: {
                  self.arrayView.transform = CGAffineTransform(translationX: 0, y: 0)
               })
            }
         }
      }
   }
   // Animations for each orientation state
   private func upAnimation() {
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                     initialSpringVelocity: 0, options:.curveEaseInOut, animations: {
                        self.backgroundGrid.transform = CGAffineTransform(translationX:0 , y: 50)
      }) { (_) in
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                        initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                           self.backgroundGrid.transform = CGAffineTransform(translationX: 0,
                                                                        y: -self.view.frame.height)
                           self.swipeUpLabel.text = "GREAT !"
                           self.swipeUpLabel.textColor = #colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)
                           self.arrayView.transform = CGAffineTransform(translationX: 0,
                                                                        y: -self.view.frame.height)
                           self.shareImage()
         })
      }
   }
   
   private func leftAnimation() {
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                     initialSpringVelocity: 0, options:.curveEaseInOut, animations: {
                        self.backgroundGrid.transform = CGAffineTransform(translationX: 50 , y: 0)
      }) { (_) in
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                        initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                           self.backgroundGrid.transform = CGAffineTransform(translationX:
                              -self.view.frame.width , y: 0)
                           self.swipeLeftLabel.text = "GREAT !"
                           self.swipeLeftLabel.textColor = #colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)
                           self.arrayView.transform = CGAffineTransform(translationX:
                              -self.view.frame.width/2, y: 0)
                           self.shareImage()
         })
      }
   }
   
   // Animation keeping default parameters after sending/cencelled sharing
   private func animationReset() {
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5,
                     options:.curveEaseInOut, animations: {
                        if UIDevice.current.orientation.isPortrait {
                           self.backgroundGrid.transform = CGAffineTransform(translationX: 0, y: 50)
                        } else if UIDevice.current.orientation.isLandscape {
                           self.backgroundGrid.transform = CGAffineTransform(translationX: 50, y: 0)
                        }
      }) { (_) in
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,
                        initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                           self.backgroundGrid.transform = CGAffineTransform(translationX: 0, y: 0)
                           self.arrayView.transform = CGAffineTransform(translationX: 0, y: 0)
                           self.swipeUpLabel.textColor = #colorLiteral(red: 0.9999060035, green: 1, blue: 0.9998731017, alpha: 1)
                           self.swipeLeftLabel.textColor = #colorLiteral(red: 0.9999060035, green: 1, blue: 0.9998731017, alpha: 1)
                           self.swipeUpLabel.text = "Swipe up to share"
                           self.swipeLeftLabel.text = "Swipe left to share"
         })
      }
   }
   
   //   Function sharing image
   func shareImage() {
      let imageToShare: UIImage = backgroundGrid.asImage()
      
      let activityController = UIActivityViewController(activityItems: [imageToShare],
                                                        applicationActivities: nil)
      activityController.completionWithItemsHandler = { (nil,completed, _, error)
         in
         if completed {
            self.animationReset()
         } else {
            self.animationReset()
         }
      }
      present(activityController, animated: true)
   }
}

// Disable landscape ImagePickerController bug
extension UIImagePickerController {
   override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return .all
   }
}

// Transform an UIView into an UIImage for share
extension UIView {
   func asImage() -> UIImage {
      let renderer = UIGraphicsImageRenderer(bounds: bounds)
      return renderer.image { rendererContext in
         layer.render(in: rendererContext.cgContext)
      }
   }
}
