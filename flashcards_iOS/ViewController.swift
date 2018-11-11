//
//  ViewController.swift
//  Flashcards
//
//  Created by porcupal on 10/13/18.
//  Copyright © 2018 porcupal. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String;
    var answer: String;
    var optOne: String; // struct Derivations
    var optTwo: String; // struct Derivations
    var optThree: String; // struct Derivations
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcardsArray = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        
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
        
        if (flashcardsArray.count == 0) {
            updateFlashcard(question: "What are the 2 types of DEs?", answer: "Linear and Seperable", optOne: "Continuous and Differentiable", optTwo: "Split and Straight", optThree: "Linear and Seperable")
        } else {
            updateLabels()
            updatePrevNextButton()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = (frontLabel.isHidden ? false: true)
    }
    func updateFlashcard(question: String, answer: String, optOne: String, optTwo: String, optThree: String) {
        let flashcard = Flashcard(question: question, answer: answer, optOne: optOne, optTwo: optTwo, optThree: optThree)
        
        flashcardsArray.append(flashcard)
        print("🤓 Flashcard added")
        currentIndex = flashcardsArray.count - 1
        print("🤓 We now have \(flashcardsArray.count) Flashcards")
        
        updatePrevNextButton()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    func updatePrevNextButton() {
        // disable 'Next' button if flashcardsArray is at end
        if (currentIndex == flashcardsArray.count - 1) {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // disable 'Prev' button if flashcardsArray is at begin
        if (currentIndex == 0) {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    func updateLabels() {
        // get current Flashcard
        let currentFlashcard = flashcardsArray[currentIndex]
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        btnOptionOne.setTitle(currentFlashcard.optOne, for: .normal)
        btnOptionTwo.setTitle(currentFlashcard.optTwo, for: .normal)
        btnOptionThree.setTitle(currentFlashcard.optThree, for: .normal)
    }
    func saveAllFlashcardsToDisk() {
        let flashcardsDict = flashcardsArray.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "optOne": card.optOne, "optTwo": card.optTwo, "optThree": card.optThree]
        }
        UserDefaults.standard.set(flashcardsDict, forKey: "flashcards")
        
        print("🎉 Flashcards saved to UserDefaults")
    }
    func readSavedFlashcards() {
        if let flashcardsDict = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
           
            // we know for sure that we have a dict
            let savedCards = flashcardsDict.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, optOne: dictionary["optOne"]!, optTwo: dictionary["optTwo"]!, optThree: dictionary["optThree"]!)
            }
            
            flashcardsArray.append(contentsOf: savedCards)
        }
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
    @IBAction func didTapPrev(_ sender: Any) {
        currentIndex -= 1
        updateLabels()
        updatePrevNextButton()
        
    }
    @IBAction func didTapNext(_ sender: Any) {
        currentIndex += 1
        updateLabels()
        updatePrevNextButton()
    }
    
    @IBAction func didTapOnBG(_ sender: Any) {
        frontLabel.isHidden = false
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        // for the editing creation screen
        if (segue.identifier == "EditSegue") {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialOptOne = btnOptionOne.title(for: .normal)
            creationController.initialOptTwo = btnOptionTwo.title(for: .normal)
            creationController.initialOptThree = btnOptionThree.title(for: .normal)
        }
    }
}

