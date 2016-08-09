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
    let red1 : String
    let red2: String
    let red3 : String
    let blue1 : String
    let blue2 : String
    let blue3 : String
    let matchNumber : Int
}

struct Constants {
    static let tbaHeaders = [
        "X-TBA-App-Id" : "frc5188:scouting-system:v02",
        "Accept" : "application/json"
    ]
    static let tbaURL = "https://www.thebluealliance.com/api/v2/"
}

class TBAUtils : NSObject {
    static func callTBA(url:String, callBack: (data: JSON) -> ()) {
        Alamofire.request(.GET, Constants.tbaURL+url, headers: Constants.tbaHeaders).responseJSON { response in
            switch(response.result) {
                case .Success(let data):
                    let json = JSON(data)
                    callBack(data: json)
                case .Failure(let error):
                    print("Alamofire request failed. Error: \(error)")
            }
        }
    }
}


