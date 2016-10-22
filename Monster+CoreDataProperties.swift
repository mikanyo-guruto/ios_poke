//
//  Monster+CoreDataProperties.swift
//  test1
//
//  Created by Student on 2016/10/22.
//  Copyright © 2016年 Student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Monster {

    @NSManaged var no: NSNumber?
    @NSManaged var name: String?

}
