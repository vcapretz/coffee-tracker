//
//  CoffeeTableViewController.swift
//  CafeTracker
//
//  Created by Vitor Capretz on 05/02/18.
//  Copyright © 2018 Vitor Capretz. All rights reserved.
//

import UIKit

class CoffeeTableViewController: UITableViewController {
    //MARK: Properties
    
    var coffees = [Coffee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleCoffees()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
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
}
