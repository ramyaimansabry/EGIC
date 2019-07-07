//
//  Client.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

struct Client: Decodable {
    var user_id: Int = 0
    var name: String = ""
    var mobile: String = ""
    var token: String = ""
    var language: String?
}

extension Client {
    fileprivate func constructDict() -> [String: Any]{
        return ["name": self.name,
                "mobile": self.mobile,
                "user_id": self.user_id,
                "token": self.token,
                "language": self.language ?? "en"]
    }
    
    func login(){
        let dic = self.constructDict()
        UserDefaults.standard.set(dic, forKey: "loggedInClient")
    }
}
