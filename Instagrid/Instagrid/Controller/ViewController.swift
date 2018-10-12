//
//  ViewController.swift
//  Instagrid
//
//  Created by Carlos Garcia-Muskat on 28/09/2018.
//  Copyright © 2018 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var gridArea: UIView!
    @IBOutlet weak var grid1: UIStackView!
    @IBOutlet weak var grid3: UIStackView!
    @IBOutlet weak var grid2: UIStackView!
    @IBOutlet var gridButtons: [UIStackView]!
    
    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    enum gridStyle {
        case grid1, grid2, grid3
    }
    var style:gridStyle = .grid1 {
        didSet {
            setView(style)
        }
    }
    private func setView(_ style: gridStyle){
        switch style {
        case .grid1:
            grid2.isHidden = true
            grid3.isHidden = true
        case .grid2:
            grid1.isHidden = true
            grid3.isHidden = true
        case .grid3:
            grid1.isHidden = true
            grid2.isHidden = true
        }
    }
    @IBAction func didTapGrid1() {
        getNewGrid()
    }
    private func getNewGrid(){
        
    }
}

