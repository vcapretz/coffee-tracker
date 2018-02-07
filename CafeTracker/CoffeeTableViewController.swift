//
//  CoffeeTableViewController.swift
//  CafeTracker
//
//  Created by Vitor Capretz on 05/02/18.
//  Copyright © 2018 Vitor Capretz. All rights reserved.
//

import os.log
import UIKit

class CoffeeTableViewController: UITableViewController {
    //MARK: Properties
    
    var coffees = [Coffee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedCoffees = loadCoffees() {
            coffees += savedCoffees
        } else {
            loadSampleCoffees()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let coffeeDetailViewController = segue.destination as? CoffeeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCoffeeCell = sender as? CoffeeTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "noNameWhat")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCoffeeCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCoffee = coffees[indexPath.row]
            coffeeDetailViewController.coffee = selectedCoffee
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "noNameWhat")")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coffees.remove(at: indexPath.row)
            saveCoffees()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CoffeeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoffeeTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cellIdentifier).")
        }
        
        let coffee = coffees[indexPath.row]
        
        cell.nameLabel.text = coffee.name
        cell.photoImageView.image = coffee.photo
        cell.ratingControl.rating = coffee.rating
        
        return cell
    }
    
    //MARK: Actions
    @IBAction func unwindToCoffeeList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CoffeeViewController, let coffee = sourceViewController.coffee {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                coffees[selectedIndexPath.row] = coffee
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: coffees.count, section: 0)
                coffees.append(coffee)
                
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        saveCoffees()
    }
    
    //Mark: Private Methods
    private func loadSampleCoffees() {
        let photo1 = UIImage(named: "coffee1")
        let photo2 = UIImage(named: "coffee2")
        let photo3 = UIImage(named: "coffee3")
        
        guard let coffee1 = Coffee(name: "Hot Chocolate", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate coffee1")
        }
        
        guard let coffee2 = Coffee(name: "Hipster Coffee", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate coffee2")
        }
        
        guard let coffee3 = Coffee(name: "Coffee with Art", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate coffee3")
        }
        
        coffees += [coffee1, coffee2, coffee3]
    }
    
    private func saveCoffees() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(coffees, toFile: Coffee.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Coffees successuly saved", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save coffees", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCoffees() -> [Coffee]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Coffee.ArchiveURL.path) as? [Coffee]
    }
}
