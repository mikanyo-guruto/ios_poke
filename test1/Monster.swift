//
//  Monster.swift
//  test1
//
//  Created by Student on 2016/10/29.
//  Copyright © 2016年 Student. All rights reserved.
//

import UIKit
import CoreData

@objc(Monster)
class Monster: NSManagedObject {
    
    @NSManaged var no: Int16
    @NSManaged var name: String
}