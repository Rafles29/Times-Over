//
//  VerifyGuessesViewController.swift
//  Times Over
//
//  Created by Rafal Wozniak on 19/04/2020.
//  Copyright © 2020 Rafal Wozniak. All rights reserved.
//

import UIKit

class VerifyGuessesViewController: UIViewController {
    
    var phrases: [String] = []
    var answers: [Bool] = []
    let gameManager = GameManager.gameManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        teamLabel.text = gameManager.team
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        var goodPhrases: [String] = []
        for (index, phrase) in phrases.enumerated() {
            if answers[index] == true {
                goodPhrases.append(phrase)
            }
        }
        gameManager.miniRoundEnded(guessedPhrases: goodPhrases)
        let vc = navigationController?.viewControllers[navigationController!.viewControllers.count - 3]
        if gameManager.isGameEnded {
            performSegue(withIdentifier: K.Seguies.endGame, sender: self)
            return
        }
        navigationController?.popToViewController(vc!, animated: true)
    }

}


extension VerifyGuessesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.answers[indexPath.row] = !answers[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        self.setCell(cell!, indexPath: indexPath)
    }
    
}

extension VerifyGuessesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phrases.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = phrases[indexPath.row]
        cell.textLabel?.textAlignment = .center
        setCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        if answers[indexPath.row] {
            cell.textLabel?.textColor = .green
        } else {
            cell.textLabel?.textColor = .red
        }
    }
    
    
}
