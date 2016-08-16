//
//  ViewDataTableViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit
import Firebase

class Team {
    var teamNumber : String = ""
    var shotsAttempted = 0
    var shotsMade = 0
    var shotPercentage : Double {
        if (shotsAttempted < 1) {
            return 0.0
        }
        return (Double (shotsMade) / Double (shotsAttempted))
    }
    
    init(teamNumber : String, shotsAttempted : Int, shotsMade : Int) {
        self.teamNumber = teamNumber
        self.shotsAttempted = shotsAttempted
        self.shotsMade = shotsMade
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
                for team in self.teams {
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
        return teams.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("viewDataCell", forIndexPath: indexPath)
        cell.textLabel?.text = teams[indexPath.row].teamNumber
        cell.detailTextLabel!.text = "\(teams[indexPath.row].shotPercentage)"
        return cell
    }

}
