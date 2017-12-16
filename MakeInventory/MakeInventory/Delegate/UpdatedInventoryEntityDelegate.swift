//
//  UpdatedInventoryEntityDelegate.swift
//  MakeInventory
//
//  Created by Erik Perez on 12/16/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import Foundation
import CoreData

protocol UpdatedInventoryEntityDelegate {
    func refreshManagedObject(_ object: NSManagedObject)
}
