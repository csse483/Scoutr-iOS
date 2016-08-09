//
//  RecordDataViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit

class RecordDataViewController: UIViewController {

    @IBAction func pressedSaveMatchData(sender: AnyObject) {
        let viewControllers = navigationController!.viewControllers
        let destinationViewController = viewControllers[viewControllers.count-2] as! HomeScreenViewController
        destinationViewController.matchCount += 1
        navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
