//
//  DetailViewController.swift
//  MakeInventory
//
//  Created by Erik Perez on 11/14/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData


class DetailViewController: UIViewController {
    
    var inventoryDelegate: UpdatedInventoryEntityDelegate?
    let stack = CoreDataStack.instance
    var item: Inventory!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateInventory()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton){
        deleteInventory()
        navigationController?.popViewController(animated: true)
    }
    
    func updateInventory() {
        // TODO: Use predicates instead.
        // This is bad. You don't want to fetch all the 'Inventory' items
        let inventoryEntities = stack.fetchRecordsForEntity("Inventory", inManagedObjectContext: stack.viewContext)
        let entityToUpdate = inventoryEntities.filter { (object) -> Bool in
            return object.value(forKey: "name") as? String  == self.item.name &&
                object.value(forKey: "date") as? String == self.item.date &&
                object.value(forKey: "quantity") as? Int64 == self.item.quantity
        }
        let entityObjectID = entityToUpdate[0].objectID
        let backgroundEntity = stack.privateContext.object(with: entityObjectID)
        
        backgroundEntity.setValue(nameTextField.text!, forKey: "name")
        backgroundEntity.setValue(Int64(quantityTextField.text!), forKey: "quantity")
        stack.saveTo(context: stack.privateContext)
        
        inventoryDelegate?.refreshManagedObject(entityToUpdate[0])
    }
    
    func deleteInventory(){
        // TODO: Use predicates instead.
        // This is bad. You don't want to fetch all the 'Inventory' items
        let inventoryEntities = stack.fetchRecordsForEntity("Inventory", inManagedObjectContext: stack.viewContext)
        
        let entityToDelete = inventoryEntities.filter { (object) -> Bool in
            return object.value(forKey: "name") as? String == self.item.name &&
                object.value(forKey: "date") as? String == self.item.date &&
                object.value(forKey: "quantity") as? Int64 == self.item.quantity
        }
        let entityObjectID = entityToDelete[0].objectID
        let backgroundEntity = stack.privateContext.object(with: entityObjectID)
        stack.privateContext.delete(backgroundEntity)
        stack.saveTo(context: stack.privateContext)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = item.name
        nameTextField.text = item.name
        quantityTextField.text = String(item.quantity)
    }
}

