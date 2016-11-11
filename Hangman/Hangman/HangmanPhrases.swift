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
    
    var guessArray: [String]
    
    var unguessedLetters: [String]
    
    var errorCount: Int = 0
    
    // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
    init() {
        let path = Bundle.main.path(forResource: "phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
        guessArray = []
        unguessedLetters = []
    }
    
    // Get random phrase from all available phrases
    func getRandomPhrase() -> String! {
        let index = Int(arc4random_uniform(UInt32(phrases.count)))
        let selectedPhrase = phrases.object(at: index) as! String
        
        for character in selectedPhrase.characters {
            unguessedLetters.append("\(character)")
        }
        return selectedPhrase
    }
    
    func addGuess(letter: String) -> [Int] {
        if letter.characters.count == 1 {
            guessArray.append(letter)
        }
        var letterLocations = [Int]()
        var index = 0
        for character in unguessedLetters {
            if "\(character)" == letter {
                letterLocations.append(index)
            }
            index += 1
        }
        guessArray.append(letter)
        return letterLocations
    }
    
}
