//
//  SettingsViewController.swift
//  Times Over
//
//  Created by Rafal Wozniak on 19/04/2020.
//  Copyright © 2020 Rafal Wozniak. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let gameManager = GameManager.gameManager()

    @IBOutlet weak var team2NameTextField: UITextField!
    @IBOutlet weak var team1NameTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let team1Name = team1NameTextField.text,
              let team2Name = team2NameTextField.text,
              let time = Int(timeTextField.text ?? "")
                else {return}
        gameManager.prepareGame(team1Name: team1Name, team2Name: team2Name, time: time)
        performSegue(withIdentifier: K.Seguies.settingsToPhrases, sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
