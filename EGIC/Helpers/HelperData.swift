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
    final let serverBasePath = "https://1301201905092018.com/egic/mobile/api"
    var loggedInClient: Client = Client()
   
    
    private init(){
        
    }
}
