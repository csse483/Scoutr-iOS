//
//  SetUpTournamentTableViewController.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit

class SetUpTournamentTableViewController: UITableViewController {
    
    var tournaments : [Tournament] = []
    let cellIdentifier = "tournamentCell"
    let segueIdentifier = "unwindToHome"
    
    struct Tournament {
        let key : String
        let name : String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addFakeData() //TODO: Remove this when JSON parsing of TBA data is implemented
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addFakeData() {
        tournaments.append(Tournament(key: "2016abca", name: "Western Canada Regional"))
        tournaments.append(Tournament(key: "2016alhu", name: "Rocket City Regional"))
        tournaments.append(Tournament(key: "2016arc", name: "Archimedes Division"))
        tournaments.append(Tournament(key: "2016arlr", name: "Arkansas Rock City Regional"))
        tournaments.append(Tournament(key: "2016aroz", name: "Ozark Mountain Brawl"))
        tournaments.append(Tournament(key: "2016ausy", name: "Australia Regional"))
        tournaments.append(Tournament(key: "2016azfl", name: "Arizona North Regiona"))
        
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tournaments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel!.text = tournaments[indexPath.row].name
        cell.detailTextLabel!.text = tournaments[indexPath.row].key
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(segueIdentifier, sender: tournaments[indexPath.row].key)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == segueIdentifier) {
            let destinationViewController = segue.destinationViewController as! HomeScreenViewController
            destinationViewController.tournamentKey = (sender as! String)
            NSLog("Going back to home screen. Set up for the \(sender as! String)")
        }
    }
 

}
