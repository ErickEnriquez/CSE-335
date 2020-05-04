//
//  WebViewController.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/16/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import UIKit

class WebViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var web_table: UITableView!
    var Results:Food_object?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50//(Results?.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "api_cell", for: indexPath)
        let food = Results?.results[indexPath.row]
        cell.textLabel?.text = food?.title
        return cell
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.spoonacular.com/recipes/search?query=Chicken&number=50&apiKey=cfeb4a8b315f43edb09d91e3a36ffac1"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url){ (data, _ ,err) in
            DispatchQueue.main.async {
                if let err = err{
                    print("THERE HAS BEEN ERROR" , err)
                    return
                }
                guard let data = data else {return}
                //print("DATA RECIEVED",data)
                do{
                    let decoder = JSONDecoder()
                    self.Results = try decoder.decode(Food_object.self, from: data)
                    self.web_table.reloadData()
                } catch let jsonErr{
                    print("ERROR Conversion" ,jsonErr)
                }
               
               /* for temp in self.Results!.results{
                    print(temp.title)
                    print("Ready in", temp.readyInMinutes, "Minutes")
                    print(temp.id)
                }*/
                
            }
            
        }
        .resume()
        // Do any additional setup after loading the view.
    }
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_web_detail"{
            let index : IndexPath = self.web_table.indexPath(for: sender as! UITableViewCell)!//index of the cell
            if let dest: Web_detail_ViewController = segue.destination as? Web_detail_ViewController{
                dest.Food_item = Results?.results[index.row]
            }
        }
    }
    
    
    @IBAction func unwind_to_web(segue: UIStoryboardSegue){
        if segue.source is Web_detail_ViewController{
            print("Back from web view")
        }
    }
    

}
