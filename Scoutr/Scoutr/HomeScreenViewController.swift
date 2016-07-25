//
//  HomeScreenViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var tournamentKey : String?
    let setUpTournamentSegueIdentifier = "setUpTournamentSegue"
    let viewDataSegueIdentifier = "viewDataSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
