

import UIKit


struct Product: Decodable {
    let id: Int
    let parent: String?
    let views: String?
    let new: String?
    let title: String
    let image: String
    let plan: String?
    let dimensions: String
    let x3d: String?
}
