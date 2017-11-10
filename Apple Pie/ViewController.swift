//
//  ViewController.swift
//  Apple Pie
//
//  Created by Chantal Stangenberger on 09-11-17.
//  Copyright © 2017 Chantal Stangenberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["frequent", "xylofoon", "chronologisch", "autoband", "telefooncel", "programmeren"]
    
    let incorrectMovesAllowed = 7
    
    // Makes sure a new round begins after a win.
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    // Makes sure a new round begins after a lost.
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    // When a button is pressed the button will be read and enabled.
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var currentGame: Game!
    
    // Each round begins with the selection of a new word, and resetting the number of moves the player can make to incorrectMovesAllowed.
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
                               incorrectMovesRemaining: incorrectMovesAllowed,
                               guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    // Determines if a game is won or lost.
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
        totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    // Handles the interface updates.
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    // Enables or disables the collection of buttons by looping through them.
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

