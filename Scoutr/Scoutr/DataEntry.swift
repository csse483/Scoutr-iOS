//
//  DataEntry.swift
//  Scoutr
//
//  Created by CSSE Department on 8/9/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit
import Firebase

enum AutoType:Int {
    case Regular
    case pyramidFiveDisk
    case pyramidSevenDisk
    case centerFiveDisk
}

class DataEntry: NSObject {
    var autoShotsAttempted : Int
    var autoShotsMade : Int
    var safeShotsAttempted : Int
    var safeShotsMade : Int
    var fullCourtShotsAttempted : Int
    var fullCourtShotsMade : Int
    var dumpShotsAttempted : Int
    var dumpShotsMade : Int
    var disksLoadedFromFloor : Int
    var disksLoadedFromHP : Int
    var pyramidLevelClimbed : Int
    var autoType:AutoType
    
    init(autoShotsAttempted:Int, autoShotsMade:Int, safeShotsAttempted:Int, safeShotsMade:Int, fullCourtShotsAttempted:Int, fullCourtShotsMade:Int, dumpShotsAttempted:Int, dumpShotsMade:Int, disksLoadedFromFloor:Int, disksLoadedFromHP:Int, pyramidLevelClimbed:Int, autoType:AutoType) {
        self.autoShotsAttempted = autoShotsAttempted
        self.autoShotsMade = autoShotsMade
        self.safeShotsAttempted = safeShotsAttempted
        self.safeShotsMade = safeShotsMade
        self.fullCourtShotsAttempted = fullCourtShotsAttempted
        self.fullCourtShotsMade = fullCourtShotsMade
        self.dumpShotsAttempted = dumpShotsAttempted
        self.dumpShotsMade = dumpShotsMade
        self.disksLoadedFromFloor = disksLoadedFromFloor
        self.disksLoadedFromHP = disksLoadedFromHP
        self.pyramidLevelClimbed = pyramidLevelClimbed
        self.autoType = autoType
    }
    
    init (snapshot : FIRDataSnapshot) {
        self.autoShotsAttempted = snapshot.value!["autoShotsAttempted"] as! Int
        self.autoShotsMade = snapshot.value!["autoShotsMade"] as! Int
        self.safeShotsAttempted = snapshot.value!["safeShotsAttempted"] as! Int
        self.safeShotsMade = snapshot.value!["safeShotsMade"] as! Int
        self.fullCourtShotsAttempted = snapshot.value!["fullCourtShotsAttempted"] as! Int
        self.fullCourtShotsMade = snapshot.value!["fullCourtShotsMade"] as! Int
        self.dumpShotsAttempted = snapshot.value!["dumpShotsAttempted"] as! Int
        self.dumpShotsMade = snapshot.value!["dumpShotsMade"] as! Int
        self.disksLoadedFromFloor = snapshot.value!["disksLoadedFromFloor"] as! Int
        self.disksLoadedFromHP = snapshot.value!["disksLoadedFromHP"] as! Int
        self.pyramidLevelClimbed = snapshot.value!["pyramidLevelClimbed"] as! Int
        self.autoType = snapshot.value!["autoType"] as! AutoType
    }
    
    func getSnapshotValue() -> NSDictionary {
        let data:NSMutableDictionary = [:]
        data.setValue(self.autoShotsAttempted, forKey: "autoShotsAttempted")
        data.setValue(self.autoShotsMade, forKey: "autoShotsMade")
        data.setValue(self.safeShotsAttempted, forKey: "safeShotsAttempted")
        data.setValue(self.safeShotsMade, forKey: "safeShotsMade")
        data.setValue(self.fullCourtShotsAttempted, forKey: "fullCourtShotsAttempted")
        data.setValue(self.fullCourtShotsMade, forKey: "fullCourtShotsMade")
        data.setValue(self.dumpShotsAttempted, forKey: "dumpShotsAttempted")
        data.setValue(self.dumpShotsMade, forKey: "dumpShotsMade")
        data.setValue(self.disksLoadedFromFloor, forKey: "disksLoadedFromFloor")
        data.setValue(self.disksLoadedFromHP, forKey: "disksLoadedFromHP")
        data.setValue(self.pyramidLevelClimbed, forKey: "pyramidLevelClimbed")
        data.setValue(self.autoType.rawValue, forKey: "autoType")
        return data
        
    }
    
    
}
