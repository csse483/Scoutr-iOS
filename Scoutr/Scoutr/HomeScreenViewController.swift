//
//  HomeScreenViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit


enum FieldStation {
    case Red1, Red2, Red3, Blue1, Blue2, Blue3
}

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var tournamentLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var viewDataButton: HomeScreenButton!
    @IBOutlet weak var scoutNextMatchButton: HomeScreenButton!
    
    var tournament : Tournament?
    var fieldStation : FieldStation?
    
    let setUpTournamentSegueIdentifier = "setUpTournamentSegue"
    let viewDataSegueIdentifier = "viewDataSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
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
        }
        else {
            if (!viewDataButton.enabled) {
                //If the button was disabled, that means the tournament state was just changed. Reload all the match data from TBA
                getMatchDataFromTBA()
            }
            viewDataButton.enabled = true;
            scoutNextMatchButton.enabled = true;
            tournamentLabel.text = NSString.localizedStringWithFormat("%@\r%@", "Tournament:", "\(tournament!.name) - \(fieldStation!)") as String
            self.view.backgroundColor = self.fieldStation!.hashValue > 2 ? UIColor(red: 205/256, green: 253/256, blue: 253/256, alpha: 1): UIColor(red: 247/256, green: 211/256, blue: 211/256, alpha: 1)
            //TODO: Put data into match and team labels
        }
    }
    
    func getMatchDataFromTBA() {
        //TODO
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSLog("Recieved memory warning.")
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
