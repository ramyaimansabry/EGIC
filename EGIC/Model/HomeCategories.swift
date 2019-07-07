
import UIKit



// MARK: - Categories
struct HomeCategories: Decodable {
    let slider: [Slider]
    let catalog: [Catalog]
}

// MARK: - Catalog
struct Catalog: Decodable {
    let id: Int
    let image: String
}

// MARK: - Slider
struct Slider: Decodable {
    let id: Int
    let title: String
    let category_id: String
    let image: String
}
