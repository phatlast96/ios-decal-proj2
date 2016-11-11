//
//  HangmanPhrases.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import Foundation

class HangmanPhrases {
    var phrases : NSArray!
    
    var incorrectGuessesArray: [String]
    
    var correctGuessesArray: [String]
    
    var lettersInPhrase: [String]
    
    var errorCount: Int = 0
    
    var isGameFinished: Bool
    
    // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
    init() {
        let path = Bundle.main.path(forResource: "phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
        incorrectGuessesArray = []
        correctGuessesArray = []
        lettersInPhrase = []
        isGameFinished = false
    }
    
    // Get random phrase from all available phrases
    func getRandomPhrase() -> String! {
        let index = Int(arc4random_uniform(UInt32(phrases.count)))
        let selectedPhrase = phrases.object(at: index) as! String
        
        for character in selectedPhrase.characters {
            lettersInPhrase.append("\(character)")
        }
        return selectedPhrase
    }
    
    func addGuess(letter: String) -> [Int] {
        var letterLocations = [Int]()
        var index = 0
        for character in lettersInPhrase {
            if "\(character)" == letter {
                letterLocations.append(index)
            }
            index += 1
        }
        if letterLocations.count == 0 {
            incorrectGuessesArray.append(letter)
        } else {
            correctGuessesArray.append(letter)
        }
        return letterLocations
    }
    
}
