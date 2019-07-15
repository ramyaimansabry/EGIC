

import UIKit


struct Calculate: Decodable {
    let drainItems, feedItems: [Item]
}


struct Item: Decodable {
    let name, measure: String
    let quantity: Int
}
