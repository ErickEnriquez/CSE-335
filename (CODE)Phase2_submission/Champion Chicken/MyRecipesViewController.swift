//
//  MyRecipesViewController.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/1/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import UIKit
import CoreData
class MyRecipesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    
    var counter = 1
    
    var fetchResults = [Recipe_entity]()
    
    @IBOutlet weak var recipe_table: UITableView!// handle to the table view
    
     var recipes:Recipes = Recipes()//recipies object
    
    //handle to Core Data
     let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func fetchRecord()-> Int{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe_entity")
        var x = 0
        // Execute the fetch request, and cast the results to an array of recipe objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [Recipe_entity])!
        x = fetchResults.count
        print("FETCHED " , String(x) , " RESULTS\n")
        // return how many entities in the coreData
        return x
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipes_cell", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.textLabel?.text = fetchResults[indexPath.row].food_name
        if let image = fetchResults[indexPath.row].image{
            cell.imageView?.image = UIImage(data: image as Data)
        }
        return cell

    }
    
    //allows us to delete a table entry
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    // return the table view style as deletable
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
   
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            // delete the selected object from the managed
            // object context
            managedObjectContext.delete(fetchResults[indexPath.row])
            // remove it from the fetch results array
            fetchResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try managedObjectContext.save()
            } catch {
                
            }
            // reload the table after deleting a row
            self.recipe_table.beginUpdates()
            self.recipe_table.deleteRows(at: [indexPath], with: .automatic)
            self.recipe_table.endUpdates()
            
        }
        
    }
    
    
    
    
    @IBAction func Add_item(_ sender: Any) {
        let alert = UIAlertController(title: "Enter a food name", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Enter food name here" } )
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter serving size here"})
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter ready in info"})
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Recipe details/steps"})
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            let fName = alert.textFields![0].text! //name of foof
            let fServing = alert.textFields![1].text! //serving size of food
            let fReadyIn = alert.textFields![2].text! //ready in info
            let fRecipe = alert.textFields![3].text! //Steps
            
            if fName.isEmpty == false && fServing.isEmpty == false && fReadyIn.isEmpty ==
                false && fRecipe.isEmpty == false{
                
                
                
                ///////////////////////////////////////////////////////////////////////////
                 let ent = NSEntityDescription.entity(forEntityName: "Recipe_entity", in: self.managedObjectContext)
                 let newItem = Recipe_entity(entity: ent!, insertInto: self.managedObjectContext)
                
                newItem.food_name = fName
                newItem.image = nil
                newItem.ready_in = fReadyIn
                newItem.serving_size = fServing
                newItem.steps = fRecipe
                do {
                    try self.managedObjectContext.save()
                    
                } catch let error {
                }
                ///////////////////////////////////////////////////////////////////////////
                self.recipes.add_food(fName, "nil", fReadyIn, fServing, fRecipe)
                self.recipe_table.reloadData()
                self.updateCounter()
            }
            
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert,animated:true)

    }
    
    
    func initCounter() {
        counter = UserDefaults.init().integer(forKey: "counter")
    }
    
    func updateCounter() {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    }
    
    
    //segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "to_my_recipe_detail"{
            let index : IndexPath = self.recipe_table.indexPath(for: sender as! UITableViewCell)!//index of the cell
            if let dest: MyRecipesDetailViewController = segue.destination as? MyRecipesDetailViewController{
                dest.obj = fetchResults[index.row].self
            }
        }
    }
    
    
    @IBAction func unwind_to_my_recipes_table(segue: UIStoryboardSegue){
        if segue.source is MyRecipesDetailViewController{
            print("BACK FROM DETAIL VIEW")
            self.recipe_table.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCounter()
        // Do any additional setup after loading the view.
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
