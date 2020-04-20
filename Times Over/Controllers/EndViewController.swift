//
//  EndViewController.swift
//  Times Over
//
//  Created by Rafal Wozniak on 19/04/2020.
//  Copyright © 2020 Rafal Wozniak. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    let gameManager = GameManager.gameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scoreLabel.text = "\(gameManager.team1Score):\(gameManager.team2Score)"
        
        if gameManager.team1Score > gameManager.team2Score {
            teamLabel.text = gameManager.team1Name
            view.backgroundColor = #colorLiteral(red: 0.1316423416, green: 0.5770328641, blue: 1, alpha: 1)
        }
        if gameManager.team1Score < gameManager.team2Score  {
            teamLabel.text = gameManager.team2Name
            view.backgroundColor = #colorLiteral(red: 1, green: 0.2654848695, blue: 0.3085075319, alpha: 1)
        }
        if gameManager.team1Score == gameManager.team2Score{
            teamLabel.text = "TIE"
            view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9764705882, alpha: 1)
        }
    }
    
    @IBAction func endClicked(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
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
