//
//  ViewController.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/1/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.source is MyRecipesViewController{
            print("BACK FROM MY RECIPES\n")
        }
        else if segue.source is map_ViewController{
            print("Back from map_view")
        }

    }
}

