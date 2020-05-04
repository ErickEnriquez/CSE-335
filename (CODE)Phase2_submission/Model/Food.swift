//
//  Food.swift
//  Champion Chicken (Class Project)
//
//  Created by Erick Enriquez on 11/4/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import Foundation

class Food{
    var name: String?
    var image: String?
    var ready_in: String?
    var serving_size: String?
    var steps_ingredients: String?
    
    
    init(_ n : String? ,_ i: String, _ r :String ,_ s :String ,_ steps :String){
        name = n
        image = i
        ready_in = r
        serving_size = s
        steps_ingredients = steps
    }
}


class Recipes{
    var FoodArray: [Food] = []//array of food objects
    
    init() {//initialize the Recipes list
        let placeholder = Food("FOOD","IMAGE","READY","SERVING SIZE","STEPS")
        FoodArray.append(placeholder)
    }
    
    func add_food(_ n:String, _ i:String, _ r:String,_ s:String,_ steps:String) {
        let newFood = Food(n,i,r,s,steps)//create new recipes
        FoodArray.append(newFood)//add the new food objcet
    }
    
    func get_size() ->  Int {//get the size of the food array
        return FoodArray.count
    }
    
    func get_food(_ index :Int) -> Food {
        return FoodArray[index]
    }
    
    func delete(_ index : Int){
        FoodArray.remove(at: index)
    }
}
