//
//  HomeScreenViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var tournamentLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var viewDataButton: HomeScreenButton!
    @IBOutlet weak var scoutNextMatchButton: HomeScreenButton!
    
    var tournament : Tournament? {
        didSet{getMatchDataFromTBA()}
    }
    
    var fieldStation : FieldStation?
    var matches = [Match]()
    var matchCount = 0;
    
    let setUpTournamentSegueIdentifier = "setUpTournamentSegue"
    let viewDataSegueIdentifier = "viewDataSegue"
    let recordDataSegueIdentifier = "recordDataSegueIdentifier"
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView() {
        if (tournament == nil) {
            tournamentLabel.text = "Please set up a tournament."
            matchLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Match:", "N/A") as String
            teamLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Team:", "N/A") as String
            viewDataButton.enabled = false;
            scoutNextMatchButton.enabled = false;
        } else {
            viewDataButton.enabled = true;
            scoutNextMatchButton.enabled = true;
            tournamentLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Tournament:", "\(tournament!.name) - \(fieldStation!)") as String
            self.view.backgroundColor = self.fieldStation!.hashValue > 2 ? UIColor(red: 205/256, green: 253/256, blue: 253/256, alpha: 1): UIColor(red: 247/256, green: 211/256, blue: 211/256, alpha: 1)
            if (!matches.isEmpty) {
                matchLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Match:", "\(matches[matchCount].matchNumber)") as String
                teamLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Team:", getNextTeamToScout()) as String
            }
        }
    }
    
    func getNextTeamToScout() -> String {
        var nextTeamToScout : String
        switch(fieldStation!) {
        case .Blue1:
            nextTeamToScout = matches[matchCount].blue1
        case .Blue2:
            nextTeamToScout = matches[matchCount].blue2
        case .Blue3:
            nextTeamToScout = matches[matchCount].blue3
        case .Red1:
            nextTeamToScout = matches[matchCount].red1
        case .Red2:
            nextTeamToScout = matches[matchCount].red2
        case .Red3:
            nextTeamToScout = matches[matchCount].red3
        }
        return nextTeamToScout
    }
    
    func getMatchDataFromTBA() {
        matches.removeAll()
        TBAUtils.callTBA("event/\(tournament!.key)/matches") { jsonMatches in
            for (_,match) in jsonMatches {
                if (match["comp_level"].stringValue) == "qm" {
                    let red1 = match["alliances"]["red"]["teams"][0].stringValue
                    let red2 = match["alliances"]["red"]["teams"][1].stringValue
                    let red3 = match["alliances"]["red"]["teams"][2].stringValue
                    let blue1 = match["alliances"]["blue"]["teams"][0].stringValue
                    let blue2 = match["alliances"]["blue"]["teams"][1].stringValue
                    let blue3 = match["alliances"]["blue"]["teams"][2].stringValue
                    let newMatch = Match(red1: red1,
                                         red2: red2,
                                         red3: red3,
                                         blue1: blue1,
                                         blue2: blue2,
                                         blue3: blue3,
                                         matchNumber: match["match_number"].intValue)
                    self.matches.append(newMatch)
                }
            }
            self.matches.sortInPlace({ (match1, match2) -> Bool in
                match1.matchNumber < match2.matchNumber
            })
            self.configureView()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == recordDataSegueIdentifier) {
            let controller = segue.destinationViewController as! RecordDataViewController
            controller.matchNumber = matches[matchCount].matchNumber
            controller.team = getNextTeamToScout()
            controller.tournamentKey = tournament?.key
        }
        if (segue.identifier == viewDataSegueIdentifier) {
            let controller = segue.destinationViewController as! ViewDataTableViewController
            controller.dataRef = Constants.firebaseRef.child("\(tournament!.key)")
        }
        
    }
}
