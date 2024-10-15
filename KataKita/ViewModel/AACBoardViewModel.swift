import SwiftUI
import Combine

class CardViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var cards: [Card] = []

    init() {
        loadSampleData()
    }

    private func loadSampleData() {
        // Sample Categories
        let Nouns = Category(id: UUID(), name: "Nouns", color: "Orange")
        let Pronouns = Category(id: UUID(), name: "Pronouns", color: "Yellow")
        let Verbs = Category(id: UUID(), name: "Verbs", color: "Green")
        let Adjectives = Category(id: UUID(), name: "Adjectives", color: "Blue")
        let PrepositionsSocialWords = Category(id: UUID(), name: "PrepositionsSocialWords", color: "Pink")
        let Questions = Category(id: UUID(), name: "Questions", color: "Purple")
        let NegationImportantWords = Category(id: UUID(), name: "NegationImportantWords", color: "Red")
        let Adverbs = Category(id: UUID(), name: "Adverbs", color: "Brown")
        let Conjunctions = Category(id: UUID(), name: "Conjunctions", color: "White")
        let Determiners = Category(id: UUID(), name: "Determiners", color: "Grey")

        categories = [Nouns, Pronouns, Verbs, Adjectives, PrepositionsSocialWords, Questions, NegationImportantWords, Adverbs, Conjunctions, Determiners]

        // Sample Cards
        let card1 = Card(id: UUID(), name: "sleep", image: UIImage(systemName: "sleep") ?? UIImage(), category: Verbs)
        let card2 = Card(id: UUID(), name: "wake", image: UIImage(systemName: "wake") ?? UIImage(), category: Verbs)

        cards = [card1, card2]
    }

    
}
