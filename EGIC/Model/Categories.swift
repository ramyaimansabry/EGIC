
import UIKit

struct Categories: Decodable {
    let id: Int
    let parent: String?
    let title: String
    let image: String
    let child: [Categories]
}
