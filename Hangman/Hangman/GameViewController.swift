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
    
    var incorrectGuessesTitle: UILabel!
    
    var incorrectGuesses: UILabel
    
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
        showHangmanImage(imageNumber: 1)
        
        
        answerDisplay = UILabel()
        answerDisplay.text = answerText
//        answerDisplay.frame.origin.x = self.view.center.x - 50
//        answerDisplay.frame.origin.y = hangmanDisplay.frame.origin.y + hangmanDisplay.frame.height + 30
        answerDisplay.sizeToFit()
        self.view.addSubview(answerDisplay)
        answerDisplay.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraintForAnswerDisplay = NSLayoutConstraint(item: answerDisplay, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraintForAnswerDisplay = NSLayoutConstraint(item: answerDisplay, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraints([xCenterConstraintForAnswerDisplay, yCenterConstraintForAnswerDisplay])
        
        incorrectGuessesTitle = UILabel()
//        incorrectGuessesTitle.frame.origin = CGPoint(x: hangmanDisplay.frame.origin.x, y: hangmanDisplay.frame.origin.y - 60)
        incorrectGuessesTitle.text = "Incorrect Guesses: "
        incorrectGuessesTitle.sizeToFit()
        self.view.addSubview(incorrectGuessesTitle)
        incorrectGuessesTitle.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraintForIncorrectGuessesTitle = NSLayoutConstraint(item: incorrectGuessesTitle, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let topMarginForIncorrectGuessesTitle = NSLayoutConstraint(item: incorrectGuessesTitle, attribute: .topMargin, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 70)
        self.view.addConstraints([xCenterConstraintForIncorrectGuessesTitle, topMarginForIncorrectGuessesTitle])
        
        incorrectGuesses = UILabel()
//        incorrectGuesses.frame.origin = CGPoint(x: hangmanDisplay.frame.origin.x, y: hangmanDisplay.frame.origin.y - 30)
        incorrectGuesses.text = ""
        incorrectGuesses.sizeToFit()
        self.view.addSubview(incorrectGuesses)
        incorrectGuesses.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraintForIncorrectGuesses = NSLayoutConstraint(item: incorrectGuesses, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let topMarginForIncorrectGuesses = NSLayoutConstraint(item: incorrectGuesses, attribute: .topMargin, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 100)
        self.view.addConstraints([xCenterConstraintForIncorrectGuesses, topMarginForIncorrectGuesses])
        
        
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
        self.view.addSubview(inputField)
        self.view.addSubview(incorrectGuessesTitle)
        self.view.addSubview(incorrectGuesses)
    }
    
    func enteredGuess() {
        if inputField.text == "" || hangmanPhrases.isGameFinished {
            return
        }
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
            if answerArray.index(of: "_") == nil {
                showWinState()
            }
        } else {
            hangmanPhrases.errorCount += 1
            showHangmanImage(imageNumber: hangmanPhrases.errorCount + 1)
            if hangmanPhrases.errorCount > 5 {
                showFailedState()
            }
        }
        incorrectGuesses.text! = hangmanPhrases.incorrectGuessesArray.joined()
        incorrectGuesses.sizeToFit()
        inputField.text = ""
    }
    
    func showHangmanImage(imageNumber: Int) {
        hangmanDisplay = UIImageView.init(image: UIImage.init(named: "hangman\(imageNumber).gif"))
//        hangmanDisplay.frame.origin.y = self.view.center.y / 2
//        hangmanDisplay.frame.origin.x = self.view.center.x - 50
        hangmanDisplay.sizeToFit()
        self.view.addSubview(hangmanDisplay)
        hangmanDisplay.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: hangmanDisplay, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: hangmanDisplay, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: -100)
        self.view.addConstraints([xCenterConstraint, yCenterConstraint])
    }
    
    func showWinState() {
        hangmanPhrases.isGameFinished = true
        let winningMessage = UIAlertController(title: "Congratulations!", message: "You won the game!", preferredStyle: .alert)
        winningMessage.addAction(UIAlertAction(title: "Start New Game", style: .default, handler: {(alert: UIAlertAction!) in self.newGame()}))
        self.present(winningMessage, animated: true, completion: nil)
    }
    
    func showFailedState() {
        hangmanPhrases.isGameFinished = true
        let failedMessage = UIAlertController(title: "Game Over", message: "The phrase was '" + hangmanPhrases.lettersInPhrase.joined() + "'.", preferredStyle: .alert)
        failedMessage.addAction(UIAlertAction(title: "Start Over", style: .default, handler: {(alert: UIAlertAction!) in self.newGame()}))
        self.present(failedMessage, animated: true, completion: nil)
    }
    
    func newGame() {
        let gameVC = GameViewController()
        self.present(gameVC, animated: true, completion: nil)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    init() {
        self.incorrectGuesses = UILabel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.incorrectGuesses = UILabel()
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
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
