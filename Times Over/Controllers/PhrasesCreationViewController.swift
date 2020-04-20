//
//  PhrasesCreationViewController.swift
//  Times Over
//
//  Created by Rafal Wozniak on 19/04/2020.
//  Copyright © 2020 Rafal Wozniak. All rights reserved.
//

import UIKit

class PhrasesCreationViewController: UIViewController {
    
    let gameManager = GameManager.gameManager()
    var phrases: [String] = []
    
    @IBOutlet weak var phraseTextField: UITextField!
    @IBOutlet weak var phrasesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phrasesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Prototype")
        phrasesTableView.dataSource = self
        phrasesTableView.delegate = self
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let phrase = phraseTextField.text else { return }
        phrases.append(phrase)
        phraseTextField.text = ""
        DispatchQueue.main.async {
            self.phrasesTableView.reloadData()
            self.phrasesTableView.scrollToRow(at: IndexPath(row: self.phrases.count - 1 , section: 0), at: .top, animated: true)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard phrases.count > 0 else { return }
        gameManager.setPhrases(phrases)
        performSegue(withIdentifier: K.Seguies.phrasesToRound, sender: self)
        
    }

}

extension PhrasesCreationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            self.phrases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension PhrasesCreationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phrases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = phrases[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    
}
