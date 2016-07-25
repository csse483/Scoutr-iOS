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
    
    var tournament : Tournament?
    let setUpTournamentSegueIdentifier = "setUpTournamentSegue"
    let viewDataSegueIdentifier = "viewDataSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (tournament == nil) {
            tournamentLabel.text = "Please set up a tournament."
            matchLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Match:", "N/A") as String
            teamLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Team:", "N/A") as String
            viewDataButton.enabled = false;
            scoutNextMatchButton.enabled = false;
        }
        else {
            viewDataButton.enabled = false;
            scoutNextMatchButton.enabled = false;
            tournamentLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Tournament:", tournament!.name) as String
            //TODO: Put data into match and team labels
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == setUpTournamentSegueIdentifier) {
            //let destinationViewController = segue.destinationViewController as! SetUpTournamentTableViewController
            NSLog("Going to set up tournament screen")
        }
        else if (segue.identifier == viewDataSegueIdentifier) {
            //let destinationViewController = segue.destinationViewController as! ViewDataTableViewController
            NSLog("Going to view data tournmanet screen")
        }
        
            
    }
    
    @IBAction func unwindToHome(seuge: UIStoryboardSegue){}

}
