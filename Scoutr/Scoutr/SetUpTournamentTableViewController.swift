//
//  SetUpTournamentTableViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit

struct Tournament {
    let key : String
    let name : String
}

class SetUpTournamentTableViewController: UITableViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    var filteredTournaments : [Tournament] = []
    var tournaments : [Tournament] = []
    let cellIdentifier = "tournamentCell"
    let segueIdentifier = "unwindToHome"
    var selectedStation : FieldStation? {
        didSet{
            self.performSegueWithIdentifier(self.segueIdentifier, sender: nil)
        }
    }
    var selectedTournament : Tournament?

    override func viewDidLoad() {
        super.viewDidLoad()
        addFakeData() //TODO: Remove this when JSON parsing of TBA data is implemented
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addFakeData() {
        tournaments.append(Tournament(key: "2016abca", name: "Western Canada Regional"))
        tournaments.append(Tournament(key: "2016alhu", name: "Rocket City Regional"))
        tournaments.append(Tournament(key: "2016arc", name: "Archimedes Division"))
        tournaments.append(Tournament(key: "2016arlr", name: "Arkansas Rock City Regional"))
        tournaments.append(Tournament(key: "2016aroz", name: "Ozark Mountain Brawl"))
        tournaments.append(Tournament(key: "2016ausy", name: "Australia Regional"))
        tournaments.append(Tournament(key: "2016azfl", name: "Arizona North Regiona"))
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
            cell.detailTextLabel!.text = filteredTournaments[indexPath.row].key
        }
        else {
            cell.textLabel!.text = tournaments[indexPath.row].name
            cell.detailTextLabel!.text = tournaments[indexPath.row].key
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
        ac.addAction(UIAlertAction(title: "Red 1", style: UIAlertActionStyle.Destructive, handler: {(_) in self.selectedStation = FieldStation.Red1}))
        ac.addAction(UIAlertAction(title: "Red 2", style: UIAlertActionStyle.Destructive, handler: {(_) in self.selectedStation = FieldStation.Red2}))
        ac.addAction(UIAlertAction(title: "Red 3", style: UIAlertActionStyle.Destructive, handler: {(_) in self.selectedStation = FieldStation.Red3}))
        ac.addAction(UIAlertAction(title: "Blue 1", style: UIAlertActionStyle.Default, handler: {(_) in self.selectedStation = FieldStation.Blue1}))
        ac.addAction(UIAlertAction(title: "Blue 2", style: UIAlertActionStyle.Default, handler: {(_) in self.selectedStation = FieldStation.Blue2}))
        ac.addAction(UIAlertAction(title: "Blue 3", style: UIAlertActionStyle.Default, handler: {(_) in self.selectedStation = FieldStation.Blue3}))
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(ac, animated: true) {
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == segueIdentifier) {
            let destinationViewController = segue.destinationViewController as! HomeScreenViewController
            destinationViewController.fieldStation = self.selectedStation!
            destinationViewController.tournament = selectedTournament
            NSLog("Going back to home screen. Set up for the \(selectedTournament!.name) at \(self.selectedStation)")
           
        }
    }
    
    // MARK: - Search

    func filterTournaments(searchText: String)
    {
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


