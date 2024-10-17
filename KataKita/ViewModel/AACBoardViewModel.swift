//import SwiftUI
//import Combine
//
//class CardViewModel: ObservableObject {
//    @Published var categories: [Category] = []
//    @Published var cards: [Card] = []
//
//    init() {
//        loadSampleData()
//    }
//
//    private func loadSampleData() {
//        // Sample Categories
//        let category1 = Category(id: UUID(), name: "Work", color: "Red")
//        let category2 = Category(id: UUID(), name: "Personal", color: "Blue")
//
//        categories = [category1, category2]
//
//        // Sample Cards
//        let card1 = Card(id: UUID(), name: "sleep", image: UIImage(systemName: "sleep") ?? UIImage(), category: category1)
//        let card2 = Card(id: UUID(), name: "wake", image: UIImage(systemName: "wake") ?? UIImage(), category: category2)
//
//        cards = [card1, card2]
//    }
//
//    
//}
