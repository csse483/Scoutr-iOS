//
//  RecordDataViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit
import Firebase

class RecordDataViewController: UIViewController {
    
    var matchNumber : Int?
    var team : String?
    var tournamentKey : String?
    var firebaseRef : FIRDatabaseReference?
    
    
    

    @IBAction func pressedSaveMatchData(sender: AnyObject) {
        
//        let newDataEntry = DataEntry(autoShotsAttempted: <#T##Int#>, autoShotsMade: <#T##Int#>, safeShotsAttempted: <#T##Int#>, safeShotsMade: <#T##Int#>, fullCourtShotsAttempted: <#T##Int#>, fullCourtShotsMade: <#T##Int#>, dumpShotsAttempted: <#T##Int#>, dumpShotsMade: <#T##Int#>, disksLoadedFromFloor: <#T##Int#>, disksLoadedFromHP: <#T##Int#>, pyramidLevelClimbed: <#T##Int#>, autoType: <#T##AutoType#>, match: <#T##Int#>, team: <#T##String#>)
//        firebaseRef?.childByAutoId().setValue(newDataEntry.getSnapshotValue())
        
        //Manual segue
        let viewControllers = navigationController!.viewControllers
        let destinationViewController = viewControllers[viewControllers.count-2] as! HomeScreenViewController
        destinationViewController.matchCount += 1
        navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        firebaseRef = Constants.firebaseRef.child("\(tournamentKey!)")
        super.viewDidLoad()
    }
    
}
