//
//  MyRecipesDetailViewController.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/1/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import UIKit

class MyRecipesDetailViewController: UIViewController {

    @IBOutlet weak var image_outlet: UIImageView!
    
    @IBOutlet weak var food_name_outlet: UILabel!
    
    @IBOutlet weak var serving_size_outlet: UILabel!
    
    @IBOutlet weak var ready_in_outlet: UILabel!
    
    @IBOutlet weak var recipe_details_outlet: UILabel!
    

    var obj:Recipe_entity?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        food_name_outlet.text = obj?.food_name!
        //IMAGE
        serving_size_outlet.text = obj?.serving_size!
        ready_in_outlet.text = obj?.ready_in!
        recipe_details_outlet.text = obj?.steps!
        if let image = obj?.image{
            image_outlet.image = UIImage(data: (image as? Data)!)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToDetailView(segue : UIStoryboardSegue){
        if segue.source is EditRecipeViewController{
            if let source:EditRecipeViewController = segue.destination as? EditRecipeViewController{//update the details
                obj = source.object
                food_name_outlet.text = obj?.food_name!
                serving_size_outlet.text = obj?.serving_size!
                ready_in_outlet.text = obj?.ready_in!
                recipe_details_outlet.text = obj?.steps!
                if let image = obj?.image{
                    image_outlet.image = UIImage(data: (image as? Data)!)
                }
            }
            print("Back From editing")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_edit"{
            if let viewController :EditRecipeViewController  = segue.destination as? EditRecipeViewController{
                viewController.object = obj//send the object to the edit details controller
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
