//
//  Client.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class Client: Decodable {
    var _id: Int = -1
    var name: String = ""
    var mobile: String = ""
    var token: String = ""
    
    fileprivate func constructDict() -> [String: Any]{
        return ["name": self.name,
                "mobile": self.mobile,
                "user_id": self._id,
                "token": self.token]
    }
    
    func login(){
        let dic = self.constructDict()
        UserDefaults.standard.set(dic, forKey: "loggedInClient")
    }
}
