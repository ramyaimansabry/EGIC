import UIKit

struct Store: Decodable{
   var store : String
   var latitude : String
   var longitude : String
    
    init(storesDict: [String:Any]) {
        self.store = storesDict["store"] as? String ?? "Empty Name"
        self.latitude = storesDict["latitude"] as? String ?? "0"
        self.longitude = storesDict["longitude"] as? String ?? "0"
    }
}
