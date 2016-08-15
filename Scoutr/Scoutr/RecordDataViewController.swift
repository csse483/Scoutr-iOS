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
    var autoShotsAttempted : Int?
    var autoShotsMade : Int?
    var safeShotsAttempted : Int?
    var safeShotsMade : Int?
    var fullCourtShotsAttempted : Int?
    var fullCourtShotsMade : Int?
    var dumpShotsAttempted : Int?
    var dumpShotsMade : Int?
    var disksLoadedFromFloor : Int?
    var disksLoadedFromHP : Int?
    var pyramidLevelClimbed : Int?
    var autoType : AutoType?
    
    @IBOutlet weak var autoAttempt: UILabel!
    @IBAction func autoAttemptChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        autoShotsAttempted = Int(stepper.value)
        autoAttempt.text = String(autoShotsAttempted!)
    }
    
    @IBOutlet weak var autoMade: UILabel!
    @IBAction func autoMadeChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        autoShotsMade = Int(stepper.value)
        autoMade.text = String(autoShotsMade!)
    }
    
    @IBOutlet weak var safeAttempt: UILabel!
    @IBAction func safeAttemptChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        safeShotsAttempted = Int(stepper.value)
        safeAttempt.text = String(safeShotsAttempted!)
    }
    
    @IBOutlet weak var safeMade: UILabel!
    @IBAction func safeMadeChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        safeShotsMade = Int(stepper.value)
        safeMade.text = String(safeShotsMade!)
    }
    
    @IBOutlet weak var fcAttempt: UILabel!
    @IBAction func fcAttemptChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        fullCourtShotsAttempted = Int(stepper.value)
        fcAttempt.text = String(fullCourtShotsAttempted!)
    }
    
    @IBOutlet weak var fcMade: UILabel!
    @IBAction func fcMadeChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        fullCourtShotsMade = Int(stepper.value)
        fcMade.text = String(fullCourtShotsMade!)
    }
    
    @IBOutlet weak var dumpAttempt: UILabel!
    @IBAction func dumpAttemptChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        dumpShotsAttempted = Int(stepper.value)
        dumpAttempt.text = String(dumpShotsAttempted!)
    }
    
    @IBOutlet weak var dumpMade: UILabel!
    @IBAction func dumpMadeChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        dumpShotsMade = Int(stepper.value)
        dumpMade.text = String(dumpShotsMade!)
    }
    
    @IBOutlet weak var disksFloor: UILabel!
    @IBAction func distsFloorChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        disksLoadedFromFloor = Int(stepper.value)
        disksFloor.text = String(disksLoadedFromFloor!)
    }
    
    @IBOutlet weak var disksHP: UILabel!
    @IBAction func disksHPChange(sender: AnyObject) {
        let stepper = sender as! UIStepper
        disksLoadedFromHP = Int(stepper.value)
        disksHP.text = String(disksLoadedFromHP!)
    }
    
    @IBOutlet weak var pyramidLevel: UILabel!
    @IBAction func pyramidLevelChanged(sender: AnyObject) {
        let stepper = sender as! UIStepper
        pyramidLevelClimbed = Int(stepper.value)
        pyramidLevel.text = String(pyramidLevelClimbed!)
    }
    
    
    
    
    
    
    
    
    

    @IBAction func pressedSaveMatchData(sender: AnyObject) {
        
       let newDataEntry = DataEntry(autoShotsAttempted: autoShotsAttempted!, autoShotsMade: autoShotsMade!, safeShotsAttempted: safeShotsAttempted!, safeShotsMade: safeShotsMade!, fullCourtShotsAttempted: fullCourtShotsAttempted!, fullCourtShotsMade: fullCourtShotsMade!, dumpShotsAttempted: dumpShotsAttempted!, dumpShotsMade: dumpShotsMade!, disksLoadedFromFloor: disksLoadedFromFloor!, disksLoadedFromHP: disksLoadedFromHP!, pyramidLevelClimbed: pyramidLevelClimbed!, autoType: autoType!, match: matchNumber!, team: team!)
        firebaseRef?.childByAutoId().setValue(newDataEntry.getSnapshotValue())
        
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
    
    override func viewWillAppear(animated: Bool) {
        autoShotsAttempted = 0
        autoShotsMade = 0
        safeShotsAttempted = 0
        safeShotsMade = 0
        fullCourtShotsAttempted = 0
        fullCourtShotsMade = 0
        dumpShotsAttempted = 0
        dumpShotsMade = 0
        disksLoadedFromFloor = 0
        disksLoadedFromHP = 0
        pyramidLevelClimbed = 0
        autoType = AutoType.Regular
    }
    
}
