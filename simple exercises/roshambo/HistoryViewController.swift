//
//  HistoryViewController.swift
//  RockPaperScissors
//
//  Created by Joseph Park on 3/13/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var history: [RPSMatch]!
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        
        let match = self.history[indexPath.row]
        
        cell.textLabel!.text = victoryStatusDesc(match)
        cell.detailTextLabel!.text = "\(match.p1) vs \(match.p2)"
        
        return cell
        
    }
    
    func victoryStatusDesc(_ match: RPSMatch) -> String {
        if(match.p1 == match.p2) {
            return "Tie."
            
        } else if (match.p1.defeats(match.p2)) {
            return "Win!"
        } else {
            return "Loss :("
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func dismissHistory(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
