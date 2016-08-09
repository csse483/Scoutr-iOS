//
//  SetUpTournamentTableViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit
import SwiftyJSON

class SetUpTournamentTableViewController: UITableViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    var filteredTournaments : [Tournament] = []
    var tournaments : [Tournament] = []
    let cellIdentifier = "tournamentCell"
    var selectedStation : FieldStation?
    var selectedTournament : Tournament?

    override func viewDidLoad() {
        super.viewDidLoad()
        getTournamentListFromTBA()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    func getTournamentListFromTBA() {
        TBAUtils.callTBA("events/2016") { jsonTournaments in
            for(_,tournament) in jsonTournaments {
                if (tournament["official"].boolValue) {
                    self.tournaments.append(Tournament(key: tournament["key"].stringValue, name: tournament["name"].stringValue))
                }
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredTournaments.count
        }
        return tournaments.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        if searchController.active && searchController.searchBar.text != "" {
            cell.textLabel!.text = filteredTournaments[indexPath.row].name
        }
        else {
            cell.textLabel!.text = tournaments[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if searchController.active && searchController.searchBar.text != "" {
            selectedTournament = filteredTournaments[indexPath.row]
        } else {
            selectedTournament = tournaments[indexPath.row]
        }

        let ac = UIAlertController(title: "Pick a station to scout", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "Red 1", style: .Destructive, handler: { (_) in
            self.selectedStation = .Red1
            self.goBackToHomeScreen()
            }))
        ac.addAction(UIAlertAction(title: "Red 1", style: .Destructive, handler: { (_) in
            self.selectedStation = .Red1
            self.goBackToHomeScreen()
        }))
        ac.addAction(UIAlertAction(title: "Red 2", style: .Destructive, handler: { (_) in
            self.selectedStation = .Red2
            self.goBackToHomeScreen()
        }))
        ac.addAction(UIAlertAction(title: "Red 3", style: .Destructive, handler: { (_) in
            self.selectedStation = .Red3
            self.goBackToHomeScreen()
        }))
        ac.addAction(UIAlertAction(title: "Blue 1", style: .Default, handler: { (_) in
            self.selectedStation = .Blue1
            self.goBackToHomeScreen()
        }))
        ac.addAction(UIAlertAction(title: "Blue 2", style: .Default, handler: { (_) in
            self.selectedStation = .Blue2
            self.goBackToHomeScreen()
        }))
        ac.addAction(UIAlertAction(title: "Blue 3", style: .Default, handler: { (_) in
            self.selectedStation = .Blue3
            self.goBackToHomeScreen()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    func goBackToHomeScreen() {
        //let destinationViewController = segue.destinationViewController as! HomeScreenViewController
        let viewControllers = self.navigationController!.viewControllers
        let destinationViewController = viewControllers[viewControllers.count-2] as! HomeScreenViewController
        destinationViewController.fieldStation = self.selectedStation!
        destinationViewController.tournament = selectedTournament
        destinationViewController.matchCount = 0
        NSLog("Going back to home screen. Set up for the \(selectedTournament!.name) at \(self.selectedStation)")
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    // MARK: - Search

    func filterTournaments(searchText: String) {
        filteredTournaments = tournaments.filter({ (tournament) -> Bool in
            return tournament.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
}

extension SetUpTournamentTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterTournaments(searchController.searchBar.text!)
    }
}


