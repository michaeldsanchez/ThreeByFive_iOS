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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = (frontLabel.isHidden ? false: true);
    }
    
}

