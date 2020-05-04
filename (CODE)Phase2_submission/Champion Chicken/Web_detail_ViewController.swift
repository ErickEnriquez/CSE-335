//
//  Web_detail_ViewController.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/17/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import UIKit

class Web_detail_ViewController: UIViewController {

    var j_sum:json_summary?
    var Food_item:Results?
    @IBOutlet weak var Food_name_outlet: UILabel!
    @IBOutlet weak var serving_size_outlet: UILabel!
    @IBOutlet weak var ready_in_outlet: UILabel!
    @IBOutlet weak var Sumary_outlet: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Food_name_outlet.text  = Food_item?.title
        serving_size_outlet.text = String(Food_item!.servings!)
        ready_in_outlet.text = String(Food_item!.readyInMinutes!)
        let ID = String(Food_item!.id!)
        // Do any additional setup after loading the view.
        let urlString = "https://api.spoonacular.com/recipes/" + ID + "/summary?apiKey=cfeb4a8b315f43edb09d91e3a36ffac1"
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
                    let dec = JSONDecoder()
                    self.j_sum = try dec.decode(json_summary.self, from: data)
                  //  print(self.j_sum?.title)
                  //   print(self.j_sum?.summary)
                    let str = self.j_sum?.summary!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)//remove html tags
                    self.Sumary_outlet.text = str
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
