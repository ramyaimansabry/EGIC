//
//  HomeController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/7/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
 
    var bassedHomeCategories: HomeCategories?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("**********************************************")
        print("**********************************************")
        print("**********************************************")
        print(bassedHomeCategories)
        print("**********************************************")
        print("**********************************************")
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
