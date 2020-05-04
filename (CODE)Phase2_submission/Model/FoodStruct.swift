//
//  FoodStruct.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/16/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import Foundation

struct Food_object :Decodable{
    var offset:Int?
    var number:Int?
    var results :[Results]
    var totalResults:Int?
}

struct Results : Decodable{
    var id: Int?
    var image:String?
    var imageUrls:[String]
    var readyInMinutes:Int?
    var servings:Int?
    var title:String?
}

struct json_summary : Decodable{
    var id: Int?
    var summary:String?
    var title:String?
}
