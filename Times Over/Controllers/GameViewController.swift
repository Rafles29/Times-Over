//
//  GameViewController.swift
//  Times Over
//
//  Created by Rafal Wozniak on 19/04/2020.
//  Copyright © 2020 Rafal Wozniak. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upperImage: UIImageView!
    @IBOutlet weak var lowerImage: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    
    let gameManager = GameManager.gameManager()
    var phrases: [String] = []
    var answers: [Bool] = []
    var currentPhrase: String?
    var timer: Timer = Timer()
    var timeLeft = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        teamLabel.text = gameManager.team
        timeLeft = gameManager.timeLeft
        timeLabel.text = "\(timeLeft)s"
        
        if gameManager.currentMove == Teams.Team1 {
            upperImage.image = #imageLiteral(resourceName: "downBlue")
            lowerImage.image = #imageLiteral(resourceName: "middleBlue")
            checkButton.backgroundColor = #colorLiteral(red: 0.1316423416, green: 0.5770328641, blue: 1, alpha: 1)
            checkButton.borderColor = #colorLiteral(red: 0.1316423416, green: 0.5770328641, blue: 1, alpha: 1)
        } else {
            upperImage.image = #imageLiteral(resourceName: "downRed")
            lowerImage.image = #imageLiteral(resourceName: "middleRed")
            checkButton.backgroundColor = #colorLiteral(red: 1, green: 0.2654848695, blue: 0.3085075319, alpha: 1)
            checkButton.borderColor = #colorLiteral(red: 1, green: 0.2654848695, blue: 0.3085075319, alpha: 1)
        }
        
        prepareForNextRound()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.timeLeft -= 1
            if self.timeLeft < 0 {
                self.endRound()
            }
            DispatchQueue.main.async {
                self.timeLabel.text = "\(self.timeLeft)s"
            }
        })
    }
    
    func endRound() {
        timer.invalidate()
        performSegue(withIdentifier: K.Seguies.gameToVerify, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Seguies.gameToVerify {
            let vc = segue.destination as! VerifyGuessesViewController
            vc.answers = answers
            vc.phrases = phrases
        }
    }
    
    @IBAction func correctButtonPressed(_ sender: Any) {
        buttonPressed(truePressed: true)
    }
    
    @IBAction func incorrectButtonPressed(_ sender: Any) {
        buttonPressed(truePressed: false)
    }
    
    func buttonPressed(truePressed: Bool) {
        answers[answers.count - 1] = truePressed
        prepareForNextRound()
    }
    
    func prepareForNextRound() {
        currentPhrase = gameManager.nextPhrase()
        guard let currentPhrase = currentPhrase else {
            endRound()
            return
        }
        phrases.append(currentPhrase)
        answers.append(false)
        textView.text = currentPhrase
    }

}
