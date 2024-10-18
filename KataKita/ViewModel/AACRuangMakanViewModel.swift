
import SwiftUI

class AACRuangMakanViewModel: ObservableObject {
    @Published var cards: [[Card]] = []
    private var rawData: [[(String, String, String, String)]] = [] // Store the raw data separately

    init() {
        loadCardsData()
    }

    // Function to load the data and convert it to Card models
    func loadCardsData() {
        rawData = [
            [("person.fill", "saya", "#FFEBAF", "#000000"), ("person.fill", "kamu", "#FFEBAF", "#000000"), ("person.fill", "dia", "#FFEBAF", "#000000"), ("person.fill", "kita", "#FFEBAF", "#000000"), ("person.fill", "mama", "#FFEBAF", "#000000"), ("person.fill", "papa", "#FFEBAF", "#000000")],
            [("person.fill", "apa", "#A77DFF", "#000000"), ("person.fill", "dimana", "#A77DFF", "#000000"), ("person.fill", "siapa", "#A77DFF", "#000000")],
            [("person.fill", "suka", "#FFB0C7", "#000000"), ("person.fill", "tidak suka", "#FFB0C7", "#000000"), ("person.fill", "mau", "#FFB0C7", "#000000"), ("person.fill", "tidak mau", "#FFB0C7", "#000000"), ("person.fill", "tolong", "#FFB0C7", "#000000")],
            [("person.fill", "makan", "#CFF0C8", "#000000"), ("person.fill", "minum", "#CFF0C8", "#000000"), ("person.fill", "putar", "#CFF0C8", "#000000"), ("person.fill", "buka", "#CFF0C8", "#000000"), ("person.fill", "tutup", "#CFF0C8", "#000000")],
            [("person.fill", "masukkan", "#CFF0C8", "#000000"), ("person.fill", "ambil", "#CFF0C8", "#000000"), ("person.fill", "kunyah", "#CFF0C8", "#000000"), ("person.fill", "potong", "#CFF0C8", "#000000"), ("person.fill", "buang", "#CFF0C8", "#000000")],
            [("person.fill", "dingin", "#D4F3FF", "#000000"), ("person.fill", "panas", "#D4F3FF", "#000000"), ("person.fill", "asin", "#D4F3FF", "#000000"), ("person.fill", "manis", "#D4F3FF", "#000000")],
            [("person.fill", "sendok", "#F2B95C", "#000000"), ("person.fill", "garpu", "#F2B95C", "#000000"), ("person.fill", "piring", "#F2B95C", "#000000"), ("person.fill", "mangkok", "#F2B95C", "#000000"), ("person.fill", "gelas", "#F2B95C", "#000000")],
            [("person.fill", "di", "#FFFFFF", "#000000"), ("person.fill", "ke", "#FFFFFF", "#000000"), ("person.fill", "dan", "#FFFFFF", "#000000")],
            [("person.fill", "hitam", "#000000", "#000000"), ("person.fill", "cokelat", "#835737", "#835737"), ("person.fill", "oranye", "#E9AE50", "#E9AE50"), ("person.fill", "merah", "#E54646", "#E54646"), ("person.fill", "ungu", "#B378D8", "#B378D8"), ("person.fill", "pink", "#EDB0DC", "#EDB0DC"), ("person.fill", "biru", "#889AE4", "#889AE4"), ("person.fill", "hijau", "#B7D273", "#B7D273"), ("person.fill", "kuning", "#EFDB76", "#EFDB76")]
        ]
        
        var loadedCards: [[Card]] = []
        
        for (index, dataSet) in rawData.enumerated() {
            var cardsInRow: [Card] = []
            for data in dataSet {
                let icon = data.0
                let name = data.1
                let backgroundColor = data.2
                let fontColor = data.3
                
                // Create a Category for each row with the background and font color
                let category = Category(name: "Category \(index + 1)", color: backgroundColor, fontColor: fontColor)
                
                // Create the card
                let card = Card(icon: icon, name: name, category: category)
                
                cardsInRow.append(card)
            }
            loadedCards.append(cardsInRow)
        }
        
        self.cards = loadedCards
    }
    
    func addCard(icon: String, text: String, backgroundColor: String) {
        // Set default font color to black
        let fontColor = "#000000"

        // Create a new category for this card
        let category = Category(name: "New Category", color: backgroundColor, fontColor: fontColor)

        // Create the new card
        let newCard = Card(icon: icon, name: text, category: category)

        // Add the new card to the rawData
        // If there are existing rows in rawData, add to the first row; otherwise, create a new row
        if !rawData.isEmpty {
            rawData[0].append((icon, text, backgroundColor, fontColor))
        } else {
            rawData.append([(icon, text, backgroundColor, fontColor)])
        }

        // Add the new card to the cards array
        if !cards.isEmpty {
            // Add the new card to the first row of cards for simplicity
//            cards[0].append(newCard)
            cards.insert([newCard], at: 0)
        } else {
            // If no rows exist, create the first row with the new card
            cards.append([newCard])
        }

//        loadCardsData()
        
        print("Added card: \(newCard)")
    }

}
