//
//  TBAUtils.swift
//  Scoutr
//
//  Created by CSSE Department on 7/26/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum FieldStation {
    case Red1, Red2, Red3, Blue1, Blue2, Blue3
}

struct Tournament {
    let key : String
    let name : String
}
struct Match {
    let red1 : Int
    let red2: Int
    let red3 : Int
    let blue1 : Int
    let blue2 : Int
    let blue3 : Int
    let matchNumber : Int
}

struct Constants {
    static let tbaHeaders = [
        "X-TBA-App-Id" : "frc281:scouting-system:v01",
        "Accept" : "application/json"
    ]
    static let tbaURL = "https://www.thebluealliance.com/api/v2/"
}

class TBAUtils : NSObject {
    
    static func callTBA(url : String) -> [[String:AnyObject]]? {
        var jsonArray : [[String:AnyObject]]?
        Alamofire.request(.GET, Constants.tbaURL+url, headers: Constants.tbaHeaders).responseJSON { (response) in
            switch(response.result) {
            case .Success(let data):
                let jsonData = JSON(data)
                jsonArray = (jsonData.arrayObject as? [[String:AnyObject]])!
            case .Failure(let error):
                print("Alamofire request failed. Error: \(error)")
            }
        }
        return jsonArray
    }
    
}


