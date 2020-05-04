//
//  Recipe_entity+CoreDataProperties.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/4/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//
//

import Foundation
import CoreData


extension Recipe_entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe_entity> {
        return NSFetchRequest<Recipe_entity>(entityName: "Recipe_entity")
    }

    @NSManaged public var food_name: String?
    @NSManaged public var image: NSData?
    @NSManaged public var ready_in: String?
    @NSManaged public var serving_size: String?
    @NSManaged public var steps: String?

}
