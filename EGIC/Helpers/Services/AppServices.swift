
import UIKit
import Alamofire

extension ApiManager {

    func loadHomeCategories(completed: @escaping (_ valid:Bool,_ msg:String,_ homeCategories: HomeCategories?,_ code: Int)->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/home"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        Alamofire.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",nil,0)
                        return
                    }
                    if let userData = data["data"] as? [String : Any] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: userData) {
                            guard let loadedCategories = try? JSONDecoder().decode(HomeCategories.self, from: theJSONData) else {
                                print("Error: Couldn't decode data into HomeCategories")
                                completed(false,"Couldn't decode data into HomeCategories",nil,0)
                                return
                            }
                            completed(true,"Home data loaded successfully",loadedCategories,0)
                            return
                        }
                        completed(false, "Unexpected Error Please Try Again In A While",nil,0)
                        return
                    }else{
                        if let code = data["code"] as? Int {
                            completed(false, "Unexpected Error Please Try Again In A While",nil,code)
                            return
                        }
                        else {
                            completed(false, "Unexpected Error Please Try Again In A While",nil,0)
                            return
                        }
                    }
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",nil,0)
                return
            }
        }
    }


    
    
    func loadAbout(completed: @escaping (_ valid:Bool,_ msg:String,_ code: Int)->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/about"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        Alamofire.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",0)
                        return
                    }
                    if let userData = data["data"] as? [String : Any], let text = userData["about"] as? String {
                        completed(true, text,0)
                        return
                    }
                    else{
                        if let code = data["code"] as? Int {
                            completed(false, "Unexpected Error Please Try Again In A While",code)
                            return
                        }
                        else {
                            completed(false, "Unexpected Error Please Try Again In A While",0)
                            return
                        }
                    }
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",0)
                return
            }
        }
    }
    
    
    
    
    func loadStores(completed: @escaping (_ valid:Bool,_ msg:String,_ homeCategories: [Store],_ code: Int)->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/location"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        Alamofire.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",[],0)
                        return
                    }
                    if let storesData = data["data"] as? [[String : Any]] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: storesData) {
                            guard let loadedStores = try? JSONDecoder().decode([Store].self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Store")
                                completed(false,"Couldn't decode data into Store",[],0)
                                return
                            }
                            completed(true,"Stores loaded successfully",loadedStores,0)
                            return
                        }
                        completed(false, "Unexpected Error Please Try Again In A While",[],0)
                        return
                    }
                    else{
                        if let code = data["code"] as? Int {
                            completed(false, "Unexpected Error Please Try Again In A While",[],code)
                            return
                        }
                        else {
                            completed(false, "Unexpected Error Please Try Again In A While",[],0)
                            return
                        }
                    }
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",[],0)
                return
            }
        }
    }
    
    
    
    
    
    
    
}
