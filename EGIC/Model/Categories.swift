
import UIKit


struct Categories: Decodable {
    let subCategories: [subCategories]?
}

struct subCategories: Decodable {
    let id: Int?
    let parent: String?
    let title: String?
    let image: String?
    let child: [subCategories]?
}

