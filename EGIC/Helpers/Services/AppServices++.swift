import UIKit
import Alamofire

extension ApiManager {

    func loadCategories(id: String = "",completed: @escaping (_ valid:Bool,_ msg:String,_ categories: [Categories])->()){
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
                    let data = jsonResponse as! [String : Any]
                    let data2 = data["data"] as! [String : Any]
                     let categoriesData = data2["data"] as! [[String : Any]]
                    
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: categoriesData) {
                        guard let loadedStores = try? JSONDecoder().decode([Categories].self, from: theJSONData) else {
                            print("Error: Couldn't decode data into Categories")
                            completed(false,"Couldn't decode data into Categories",[])
                            return
                        }
                        
                        completed(true,"Categories loaded successfully",loadedStores)
                        return
                    }
                    
                    completed(false, "Unexpected Error Please Try Again In A While",[])
                    return
                }else {
                    completed(false, "Unexpected Error Please Try Again In A While",[])
                    return
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",[])
                return
            }
        }
    }


    
    
    
    func loadProducts(id: Int, offset: Int, limit: Int ,completed: @escaping (_ valid:Bool,_ msg:String,_ categories: [Product])->()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/products"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "lang": "\(HelperData.sharedInstance.loggedInClient.language ?? "en")",
            "Authorization": "Bearer \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        let parameters: Parameters = [
            "parent" : "\(id)",
            "count": "\(limit)",
            "page": "\(offset)",
        ]
        Alamofire.request(url, method: .get ,parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                if response.result.isSuccess {
                    let data = jsonResponse as! [String : Any]
                    let data2 = data["data"] as! [String : Any]
                    let productsData = data2["data"] as! [[String : Any]]
                    
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: productsData) {
                        guard let loadedProducts = try? JSONDecoder().decode([Product].self, from: theJSONData) else {
                            print("Error: Couldn't decode data into Product")
                            completed(false,"Couldn't decode data into Product",[])
                            return
                        }
                        
                        completed(true,"Products loaded successfully",loadedProducts)
                        return
                    }
                    
                    completed(false, "Unexpected Error Please Try Again In A While",[])
                    return
                }else {
                    completed(false, "Unexpected Error Please Try Again In A While",[])
                    return
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",[])
                return
            }
        }
    }
    
    



}
