//
//  ViewDataTableViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit
import Firebase

struct Team {
    var teamNumber : String = ""
    var shotsAttempted = 0
    var shotsMade = 0
    var shotPercentage : Double {
        return (shotsAttempted < 1) ? 0.0 : (Double(shotsMade) / Double(shotsAttempted))
    }
}

class ViewDataTableViewController: UITableViewController {
    
    var dataRef : FIRDatabaseReference?
    var teams : [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataRef?.observeSingleEventOfType(FIRDataEventType.Value, withBlock: { (snapshot:FIRDataSnapshot) in
            if (!snapshot.exists()) {
                print("Firebase error, snapshot does not exist.")
                return
            }
            for data in snapshot.children {
                var teamAdded = false
                let dataEntry = DataEntry(snapshot: data as! FIRDataSnapshot)
                for var team in self.teams {
                    if (team.teamNumber == dataEntry.team) {
                        team.shotsAttempted+=dataEntry.shotsAttempted()
                        team.shotsMade+=dataEntry.shotsMade()
                        teamAdded = true
                        break
                    }
                }
                if (!teamAdded) {
                    let newTeam = Team(teamNumber: dataEntry.team, shotsAttempted: dataEntry.shotsAttempted(), shotsMade: dataEntry.shotsMade())
                    self.teams.append(newTeam)
                }
            }
            self.teams.sortInPlace({ (a, b) -> Bool in
                return a.shotPercentage > b.shotPercentage
            })
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count+1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("viewDataCell", forIndexPath: indexPath) as! DataTableViewCell
        if (indexPath.row == 0) {
            cell.teamLabel.text = "Team"
            cell.shotsLabel.text = "Shots"
            cell.percentageLabel.text = "Accuracy"
        }
        else {
            let team = teams[indexPath.row-1]
            cell.teamLabel.text = team.teamNumber
            cell.percentageLabel.text = "\(team.shotPercentage * 100)%"
            cell.shotsLabel.text = "\(team.shotsMade)/\(team.shotsAttempted)"
        }

        return cell
    }

}
