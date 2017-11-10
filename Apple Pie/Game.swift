//
//  Game.swift
//  Apple Pie
//
//  Created by Chantal Stangenberger on 09-11-17.
//  Copyright © 2017 Chantal Stangenberger. All rights reserved.
//

import Foundation

struct Game{
    
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]

    // Increases the remaining moves by 1 for a incorrect guess
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    // Computes a version of the word that hides the missing letters.
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
                if guessedLetters.contains(letter) {
                    guessedWord += "\(letter)"
                } else {
                    guessedWord += "_"
                }
            }
            return guessedWord
        }
}

