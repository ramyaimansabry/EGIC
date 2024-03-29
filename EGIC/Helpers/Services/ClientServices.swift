import UIKit
import Alamofire

extension ApiManager {
    
    func signUp(phoneNumber: String,name: String,email: String, job_id: String, language: String, completed: @escaping (_ valid:Bool, _ msg:String,_ code: Int)->()){
//        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/user/register"
        let parameters: Parameters = [
            "mobile_number" : phoneNumber,
            "name": name,
            "email": email,
            "job_id": job_id
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "lang": language
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",0)
                        return
                    }
                    if let userData = data["data"] as? [String : Any] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: userData) {
                            guard let loggedInClient = try? JSONDecoder().decode(Client.self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Client")
                                completed(false,"Couldn't decode data into Client",0)
                                return
                            }
                            HelperData.sharedInstance.loggedInClient = loggedInClient
                            HelperData.sharedInstance.loggedInClient.language = language
                            HelperData.sharedInstance.loggedInClient.login()
                            completed(true,"User Signed in sucessfully",0)
                            return
                        }
                        completed(false, "Unexpected Error Please Try Again In A While",0)
                        return
                    }else {
                        if let code = data["code"] as? Int {
                            completed(false, "Unexpected Error Please Try Again In A While",code)
                            return
                        }
                        else {
                            completed(false, "Unexpected Error Please Try Again In A While",0)
                            return
                        }
                    }
                }else{
                    completed(false, "Unexpected Error Please Try Again In A While ",0)
                    return
                }
            }
            
            
        }
    }
    
    
    
    
    
    
    func signIn(phoneNumber: String, language: String, completed: @escaping (_ valid:Bool, _ msg:String,_ code: Int)->()){
//        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/user/auth"
        let parameters: Parameters = [
            "mobile_number" : phoneNumber,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "lang": language
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",0)
                        return
                    }
                    if let userData = data["data"] as? [String : Any] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: userData) {
                            guard let loggedInClient = try? JSONDecoder().decode(Client.self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Client")
                                completed(false,"Couldn't decode data into Client",0)
                                return
                            }
                            HelperData.sharedInstance.loggedInClient = loggedInClient
                            HelperData.sharedInstance.loggedInClient.language = language
                            HelperData.sharedInstance.loggedInClient.login()
                            completed(true,"User Signed in sucessfully",0)
                            return
                        }
                    completed(false, "Unexpected Error Please Try Again In A While",0)
                    return
                }else {
                        if let code = data["code"] as? Int {
                            completed(false, "Unexpected Error Please Try Again In A While",code)
                            return
                        }
                        else {
                        completed(false, "Unexpected Error Please Try Again In A While",0)
                        return
                       }
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",0)
                return
            }
        }
            
                
    }
}
    
    
    
    
    
}




//    let userData = data["data"] as! [String : Any]
//                    do {
//                        if let theJSONData = try? JSONSerialization.data(withJSONObject: userData) {
//                        let loggedInClient = try JSONDecoder().decode(Client.self, from: theJSONData)
//                        print(loggedInClient)
//                        }
//                    } catch {
//                        print(error)
//                    }
