import SwiftUI
import UIKit

struct Category: Identifiable {
    let id: UUID
    let name: String
    let color: String // You can use color names or hex values here
}

struct Card: Identifiable {
    let id: UUID
    let name: String
    let image: UIImage
    let category: Category
}
