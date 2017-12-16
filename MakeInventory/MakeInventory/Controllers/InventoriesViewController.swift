//
//  ViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData

class InventoriesViewController: UIViewController {
    // MARK: Properties
    
    let stack = CoreDataStack.instance
    var inventories = [Inventory]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let storedInventories = stack.fetchRecordsForEntity("Inventory", inManagedObjectContext: stack.viewContext) as! [Inventory]
        self.inventories = storedInventories
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inventoriesToDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.item = sender as! Inventory
            detailViewController.inventoryDelegate = self
        }
    }
}

// MARK: - Table View DataSource

extension InventoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = inventories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = item.name
        cell.quantityLabel.text = "x\(item.quantity)"
        cell.dateLabel.text = item.date

        return cell
    }
}

//MARK: - Table View Delegate

extension InventoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedInventory = inventories[indexPath.row]
        performSegue(withIdentifier: "inventoriesToDetail",
                     sender: selectedInventory)
    }
}

//MARK: - Inventory Delegate
extension InventoriesViewController: UpdatedInventoryEntityDelegate {
    func refreshManagedObject(_ object: NSManagedObject) {
        self.stack.viewContext.refresh(object, mergeChanges: true)
    }
}

