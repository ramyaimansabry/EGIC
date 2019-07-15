import UIKit
import Alamofire

extension ApiManager {

    func loadCategories(id: String = "",completed: @escaping (_ valid:Bool,_ msg:String,_ categories: [Categories],_ code: Int)->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/products/categories"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        let parameters: Parameters = [
            "parent" : id,
        ]
        Alamofire.request(url, method: .get ,parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",[],0)
                        return
                    }
                    if let data2 = data["data"] as? [String : Any], let categoriesData = data2["data"] as? [[String : Any]] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: categoriesData) {
                            guard let loadedStores = try? JSONDecoder().decode([Categories].self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Categories")
                                completed(false,"Couldn't decode data into Categories",[],0)
                                return
                            }
                            completed(true,"Categories loaded successfully",loadedStores,0)
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


    
    func loadProducts(id: Int, offset: Int, limit: Int ,completed: @escaping (_ valid:Bool,_ msg:String,_ categories: [Product],_ code: Int)->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/products"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        let parameters: Parameters = [
            "parent" : id,
            "count": limit,
            "page": offset,
        ]
        Alamofire.request(url, method: .get ,parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",[],0)
                        return
                    }
                    if let data2 = data["data"] as? [String : Any], let productsData = data2["data"] as? [[String : Any]] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: productsData) {
                            guard let loadedProducts = try? JSONDecoder().decode([Product].self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Product")
                                completed(false,"Couldn't decode data into Product",[],0)
                                return
                            }
                            completed(true,"Products loaded successfully",loadedProducts,0)
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
    
    

    
    func calculateBathroom(formula: String, drain: String, selectedItems: [Int] ,completed: @escaping (_ valid:Bool,_ msg:String,_ result: Calculate? ,_ code: Int)->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/calculate/bath"
        let headers: HTTPHeaders = [
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        let parameters: Parameters = [
            "formula" : formula,
            "drain": drain,
            "tub": selectedItems[2],
            "heater": selectedItems[3],
            "wmachine": selectedItems[4],
            "bidet": selectedItems[5],
            "cabin1": selectedItems[6],
            "cabin2": selectedItems[7],
            ]
        Alamofire.request(url, method: .post ,parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            print(response)
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",nil,0)
                        return
                    }
                    if let calculateDic = data["data"] as? [String : Any] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: calculateDic) {
                            guard let loadedResult = try? JSONDecoder().decode(Calculate.self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Calculate")
                                completed(false,"Couldn't decode data into Calculate",nil,0)
                                return
                            }
                            completed(true,"Products loaded successfully",loadedResult,0)
                            return
                        }
                        completed(false, "Unexpected Error Please Try Again In A While",nil,0)
                        return
                    }
                    else{
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
    
    
    
    
    func calculateKitchen(drain: String, selectedItems: [Int] ,completed: @escaping (_ valid:Bool,_ msg:String,_ result: Calculate? ,_ code: Int)->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/calculate/kitchen"
        let headers: HTTPHeaders = [
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        let parameters: Parameters = [
            "drain": drain,
            "dwasher": selectedItems[4],
            "heater": selectedItems[5],
            "wmachine": selectedItems[6],
            ]
        Alamofire.request(url, method: .post ,parameters: parameters, headers: headers).responseJSON { (response) in
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            print(response)
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    guard let data = jsonResponse as? [String : Any] else {
                        completed(false, "Unexpected Error Please Try Again In A While",nil,0)
                        return
                    }
                    if let calculateDic = data["data"] as? [String : Any] {
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: calculateDic) {
                            guard let loadedResult = try? JSONDecoder().decode(Calculate.self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Calculate")
                                completed(false,"Couldn't decode data into Calculate",nil,0)
                                return
                            }
                            completed(true,"Products loaded successfully",loadedResult,0)
                            return
                        }
                        completed(false, "Unexpected Error Please Try Again In A While",nil,0)
                        return
                    }
                    else{
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
    
}
