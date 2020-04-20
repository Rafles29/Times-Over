//
//  GameManager.swift
//  Times Over
//
//  Created by Rafal Wozniak on 19/04/2020.
//  Copyright © 2020 Rafal Wozniak. All rights reserved.
//

import Foundation

protocol GameManagerDelegate {
    func gameEnded()
    func miniRoundEnded()
}

class GameManager {
    private static let shared = GameManager()
    static func gameManager() -> GameManager {
        return self.shared
    }
    
    var team1Score = 0
    var team2Score = 0
    
    var team1Name = ""
    var team2Name = ""
    var team: String {
        return currentMove == Teams.Team1 ? team1Name : team2Name
    }
    private var time = 0
    var timeLeft: Int {
        return time
    }
    let rounds = 3
    var delegate: GameManagerDelegate?
    private var currentRound = 1
    var currentMove = Teams.Team1
    var round: Int {
        return currentRound
    }
    private var phrases: [String] = []
    private var phrasesRemainingInRound: [String] = []
    private var phrasesRemainingInMiniRound: [String] = []
    
    func nextPhrase() -> String? {
        if phrasesRemainingInMiniRound.count > 0 {
            let index = Int.random(in: 0..<phrasesRemainingInMiniRound.count)
            let phrase = phrasesRemainingInMiniRound.remove(at: index)
            return phrase
        } else {
            return nil
        }
    }
    
    func prepareGame(team1Name: String, team2Name: String, time: Int) {
        self.team1Name = team1Name
        self.team2Name = team2Name
        self.time = time
    }
    
    func setPhrases(_ phrases: [String]) {
        self.phrases = phrases
        self.phrasesRemainingInRound = self.phrases
        self.phrasesRemainingInMiniRound = self.phrases
    }
    
    func miniRoundEnded(guessedPhrases: [String]){
        for phrase in guessedPhrases {
            guard let index = self.phrasesRemainingInRound.firstIndex(of: phrase) else {
                return
            }
            self.phrasesRemainingInRound.remove(at: index)
            self.addPoint()
        }
        self.currentMove = self.currentMove == Teams.Team1 ? Teams.Team2 : Teams.Team1
        if self.phrasesRemainingInRound.count > 0 {
            self.phrasesRemainingInMiniRound = self.phrasesRemainingInRound
        } else {
            self.prepareForNextRound()
        }
        self.delegate?.miniRoundEnded()
        
    }
    
    var isGameEnded: Bool {
        if self.currentRound > self.rounds {
            return true
        }
        return false
    }
    
    private func prepareForNextRound() {
        self.phrasesRemainingInRound = self.phrases
        self.phrasesRemainingInMiniRound = self.phrases
        self.currentRound += 1
        if self.currentRound > self.rounds {
            delegate?.gameEnded()
        }
    }
    
    private func addPoint() {
        if self.currentMove == Teams.Team1 {
            team1Score += 1
        } else {
            team2Score += 1
        }
    }
}

enum Teams {
    case Team1, Team2
}
