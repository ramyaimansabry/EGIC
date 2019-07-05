//
//  HelperData.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class HelperData {
    static let sharedInstance = HelperData()
    final let serverBasePath = ""
    var loggedInClient: Client = Client()
   
    
    private init(){
        
    }
}
