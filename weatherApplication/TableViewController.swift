//
//  TableViewController.swift
//  weatherApplication
//
//  Created by Léo on 11/06/2019.
//  Copyright © 2019 Léonie Grimoin. All rights reserved.
//

import UIKit

struct CityData {
    var title : String
}

class TableViewController: UITableViewController {
    
    var cityDatas = [
        CityData(title: "Bordeaux"),
        CityData(title: "Bourges"),
        CityData(title: "Brest"),
        CityData(title: "Dijon"),
        CityData(title: "Grenoble"),
        CityData(title: "Lyon"),
        CityData(title: "Marseille"),
        CityData(title: "Montpellier"),
        CityData(title: "Nantes"),
        CityData(title: "Nice"),
        CityData(title: "Paris"),
        CityData(title: "Rennes"),
        CityData(title: "Strasbourg"),
        CityData(title: "Toulouse"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return cityDatas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        cell.textLabel?.text = cityDatas[indexPath.row].title

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCityWeather" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! citySimpleViewController
                controller.selectedCity = cityDatas[indexPath.row]
            }
        }
    }
 

}
