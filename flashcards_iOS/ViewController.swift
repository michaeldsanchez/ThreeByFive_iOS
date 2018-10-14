//
//  ViewController.swift
//  Flashcards
//
//  Created by porcupal on 10/13/18.
//  Copyright © 2018 porcupal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
      
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        btnOptionOne.layer.cornerRadius = 30.0
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.7735888662, green: 0.8320982826, blue: 0.8399825508, alpha: 1)
        
        btnOptionTwo.layer.cornerRadius = 30.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.7735888662, green: 0.8320982826, blue: 0.8399825508, alpha: 1)
        
        btnOptionThree.layer.cornerRadius = 30.0
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.7735888662, green: 0.8320982826, blue: 0.8399825508, alpha: 1)
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = (frontLabel.isHidden ? false: true)
    }
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    @IBAction func didTapOptionTwo(_ sender: Any) {
        btnOptionTwo.isHidden = true
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        frontLabel.isHidden = (frontLabel.isHidden ? false: true)
    }
    @IBAction func didTapOnBG(_ sender: Any) {
        frontLabel.isHidden = false
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false
    }
    
}

