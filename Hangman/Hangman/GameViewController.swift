//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    var hangmanDisplay: UIImageView!
    
    var inputField: UITextField!
    
    var answerDisplay: UILabel!
    
    var incorrectGuesses: UILabel!
    
    var guessButton: UIButton!
    
    var hangmanPhrases: HangmanPhrases!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase!)
        
        let phraseArray = phrase?.characters
        var answerText = ""
        for letter in phraseArray! {
            
            if letter != " " {
                answerText += "_"
            } else {
                answerText += "\(letter)"
            }
        }
        
        hangmanDisplay = UIImageView.init(image: #imageLiteral(resourceName: "hangman1.gif"))
        hangmanDisplay.frame.origin.y = self.view.center.y / 2
        hangmanDisplay.frame.origin.x = self.view.center.x - 50
        hangmanDisplay.sizeToFit()
        
        answerDisplay = UILabel()
        answerDisplay.text = answerText
        answerDisplay.frame.origin.x = self.view.center.x - 50
        answerDisplay.frame.origin.y = hangmanDisplay.frame.origin.y + hangmanDisplay.frame.height + 30
        answerDisplay.sizeToFit()
        
        incorrectGuesses = UILabel()
        incorrectGuesses.frame.origin = CGPoint(x: hangmanDisplay.frame.origin.x, y: hangmanDisplay.frame.origin.y - 30)
        incorrectGuesses.text = "Incorrect Guesses: "
        incorrectGuesses.sizeToFit()
        
        
        inputField = UITextField()
        inputField.delegate = self
        inputField.textAlignment = .center
        inputField.backgroundColor = UIColor.lightGray
        inputField.frame.origin.y = self.view.center.y + 30
        inputField.frame.origin.x = self.view.center.x - 50
        inputField.frame.size = CGSize(width: 30, height: 30)
        
    
        guessButton = UIButton()
        guessButton.backgroundColor = UIColor.blue
        guessButton.setTitle("Guess", for: .normal)
        guessButton.frame.size = CGSize(width: 70, height: inputField.frame.height)
        guessButton.addTarget(self, action: #selector(enteredGuess), for: .touchUpInside)
        guessButton.frame.origin.y = inputField.frame.origin.y
        guessButton.frame.origin.x = inputField.frame.origin.x + inputField.frame.width
        
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(detractKeyboard)))
        self.view.addSubview(guessButton)
        self.view.addSubview(answerDisplay)
        self.view.addSubview(inputField)
        self.view.addSubview(incorrectGuesses)
        self.view.addSubview(hangmanDisplay)
    }
    
    func enteredGuess() {
        let answerCharacters = answerDisplay.text?.characters
        var answerArray: [String] = []
        for character in answerCharacters! {
            answerArray.append("\(character)")
        }
        let resultIndices = hangmanPhrases.addGuess(letter: inputField.text!.capitalized)
        
        if resultIndices.count != 0 {
            for index in resultIndices {
                answerArray[index] = inputField.text!.capitalized
            }
            answerDisplay.text = answerArray.joined()
            answerDisplay.sizeToFit()
        } else {
            hangmanPhrases.errorCount += 1
        }
        inputField.text = ""
    }
    
    func detractKeyboard() {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text! = string
        return textField.text!.characters.count < 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
