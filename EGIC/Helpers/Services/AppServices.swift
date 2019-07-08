
import UIKit
import Alamofire

extension ApiManager {

    func loadHomeCategories(completed: @escaping (_ valid:Bool,_ msg:String,_ homeCategories: HomeCategories?)->()){
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
                    let data = jsonResponse as! [String : Any]
                    let userData = data["data"] as! [String : Any]
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: userData) {
                        guard let loadedCategories = try? JSONDecoder().decode(HomeCategories.self, from: theJSONData) else {
                            print("Error: Couldn't decode data into HomeCategories")
                            completed(false,"Couldn't decode data into HomeCategories",nil)
                            return
                        }

                        completed(true,"Home data loaded successfully",loadedCategories)
                        return
                    }

                    completed(false, "Unexpected Error Please Try Again In A While",nil)
                    return
                }else {
                    completed(false, "Unexpected Error Please Try Again In A While",nil)
                    return
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",nil)
                return
            }
        }
    }


    
    
    func loadAbout(completed: @escaping (_ valid:Bool,_ msg:String)->()){
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
                    let data = jsonResponse as! [String : Any]
                    let userData = data["data"] as! [String : Any]
                    
                     if let text = userData["about"] as? String {
                        completed(true, text)
                        return
                     }else {
                        completed(false, "Unexpected Error Please Try Again In A While")
                        return
                    }
                }else {
                    completed(false, "Unexpected Error Please Try Again In A While")
                    return
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    
    
}
