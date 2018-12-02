//
//  ViewController.swift
//  Flashcards
//
//  Created by porcupal on 10/13/18.
//  Copyright © 2018 porcupal. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var optOne: String
    var optTwo: String
    var optThree: String
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
    // button to remember what the correct answer is
    var correctAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        
        // Do any additional setup after loading the view
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
            // define the default state of the application
            updateFlashcard(
                            question: "What are the 2 types of DEs?",
                            answer: "Linear and Seperable",
                            optOne: "Continuous and Differentiable",
                            optTwo: "Split and Straight",
                            optThree: "Linear and Seperable",
                            isExisting: false
                            )
        } else {
            updateLabels()
            updatePrevNextButton()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // first start with the Flashcard invisible and slightly smaller in size
        card.alpha = 0.0
        btnOptionOne.alpha = 0.0
        btnOptionTwo.alpha = 0.0
        btnOptionThree.alpha = 0.0
        
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        // animate the Flashcard upon loading the application
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.btnOptionOne.alpha = 1.0
            self.btnOptionTwo.alpha = 1.0
            self.btnOptionThree.alpha = 1.0
            
            self.card.transform = CGAffineTransform.identity
            self.btnOptionOne.transform = CGAffineTransform.identity
            self.btnOptionTwo.transform = CGAffineTransform.identity
            self.btnOptionThree.transform = CGAffineTransform.identity
        })
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        // code moved to flipFlashcard() func
        flipFlashcard()
    }
    func animateCardIn(isNext: Bool) {
        let xPos = (isNext ? 300: -300)
        // Start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(xPos), y: 0.0)
        
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        } // reset transform on CardOut
    }
    func animateCardOut(isNext: Bool) {
        let xPos = (isNext ? -300: 300)
        UIView.animate(withDuration: 0.3
            , animations: {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(xPos), y: 0.0)
        }, completion: { finished in
            
            // Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardIn(isNext: isNext)
        })
    }
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3
            , options: .transitionFlipFromRight
            , animations: {
                self.frontLabel.isHidden = (self.frontLabel.isHidden ? false: true)
        })
    }

    func updateFlashcard(question: String, answer: String, optOne: String, optTwo: String, optThree: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, optOne: optOne, optTwo: optTwo, optThree: optThree)
        
        if isExisting {
            // overwrite and replace the existing Flashcard
            flashcardsArray[currentIndex] = flashcard
        } else {
            flashcardsArray.append(flashcard)
            
            // log disk writing to the console
            print("🤓 Flashcard added")
            print("🤓 We now have \(flashcardsArray.count) Flashcards")
            
            // update the current flashcardsArray index
            currentIndex = flashcardsArray.count - 1
            print("🤓 currentIndex is at \(currentIndex)")
        }
        
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
        
        // update buttons
        let buttons = [btnOptionOne, btnOptionTwo, btnOptionThree].shuffled()
        let answers = [currentFlashcard.optOne, currentFlashcard.optTwo, currentFlashcard.optThree].shuffled()
        
        for (button, answer) in zip(buttons, answers) {
            // set the title of this random button, with a random answer
            button?.setTitle(answer, for: .normal)
            
            // save the correct answer button
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
    }

    func saveAllFlashcardsToDisk() {
        let flashcardsDict = flashcardsArray.map { (card) -> [String: String] in
            return [
                    "question": card.question,
                    "answer": card.answer,
                    "optOne": card.optOne,
                    "optTwo": card.optTwo,
                    "optThree": card.optThree
                    ]
        }
        UserDefaults.standard.set(flashcardsDict, forKey: "flashcards")
        
        print("🎉 Flashcards saved to UserDefaults")
    }
    func readSavedFlashcards() {
        if let flashcardsDict = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
           
            // we know for sure that we have a dict
            let savedCards = flashcardsDict.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!,
                                 answer: dictionary["answer"]!,
                                 optOne: dictionary["optOne"]!,
                                 optTwo: dictionary["optTwo"]!,
                                 optThree: dictionary["optThree"]!)
            }
            
            flashcardsArray.append(contentsOf: savedCards)
        }
    }

    @IBAction func didTapOptionOne(_ sender: Any) {
        if btnOptionOne == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
//            btnOptionOne.isEnabled = false
        }
    }
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if btnOptionTwo == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
//            btnOptionTwo.isEnabled = false
        }
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        if btnOptionThree == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
//            btnOptionThree.isEnabled = false
        } 
    }

    @IBAction func didTapPrev(_ sender: Any) {
        animateCardOut(isNext: false)
        currentIndex -= 1
        updateLabels()
        updatePrevNextButton()
    }
    @IBAction func didTapNext(_ sender: Any) {
        animateCardOut(isNext: true)
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

    @IBAction func didTapDelete(_ sender: Any) {
        // show delete confirmation message
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you would like to delete?", preferredStyle: .actionSheet)
        
        // alert actions available: delete / cancel
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (UIAlertAction) in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // add alert actions to delete confirmation message
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    func deleteCurrentFlashcard() {
        // delete the Flashcard at currentIndex
        flashcardsArray.remove(at: currentIndex)
        
        // special case: check if one Flashcard left
        if flashcardsArray.count == 0 {
            // revert to the default Flashcard
            updateFlashcard(
                            question: "Question",
                            answer: "Answer",
                            optOne: "A",
                            optTwo: "B",
                            optThree: "C",
                            isExisting: false
                            )
        }
        // special case: check if last Flashcard was deleted
        if currentIndex > flashcardsArray.count-1 {
            currentIndex = flashcardsArray.count-1
        }
        
        // update GUI elements && store to disk
        updatePrevNextButton()
        updateLabels()
        saveAllFlashcardsToDisk()
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

