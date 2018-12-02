//
//  CreationViewController.swift
//  ThreeByFive
//
//  Created by porcupal on 10/27/18.
//  Copyright © 2018 porcupal. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var optOneTextField: UITextField!
    @IBOutlet weak var optTwoTextField: UITextField!
    @IBOutlet weak var optThreeTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialOptOne: String?
    var initialOptTwo: String?
    var initialOptThree: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        optOneTextField.text = initialOptOne
        optTwoTextField.text = initialOptTwo
        optThreeTextField.text = initialOptThree
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let optOneText = optOneTextField.text
        let optTwoText = optTwoTextField.text
        let optThreeText = optThreeTextField.text
        // lastly, check if an existing Flashcard is being edited
        let isExisting = (initialQuestion != nil) ? true: false
        
        // add alert window and 'Ok' option
        let alert = UIAlertController(title: "Missing Text", message: "You need both a question and an answer", preferredStyle: .alert)
        let optAlert = UIAlertController(title: "Missing Multiple Choice", message: "Insert options to proceed", preferredStyle: .alert)
        
        // add 'Ok' option to alert window
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        optAlert.addAction(okAction)
        
        // check valid text fields before updating flashcard
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
            present(alert, animated: true)
        }
        if (optOneText == nil || optTwoText == nil || optThreeText == nil ||
            optOneText!.isEmpty || optTwoText!.isEmpty || optThreeText!.isEmpty) {
            present(optAlert, animated:true)
        } else {
            flashcardsController.updateFlashcard(
                question: questionText!,
                answer: answerText!,
                optOne: optOneText!,
                optTwo: optTwoText!,
                optThree: optThreeText!,
                isExisting: isExisting
            );
            dismiss(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
