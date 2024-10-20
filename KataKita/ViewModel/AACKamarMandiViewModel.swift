//
//  AACKamarMandiViewModel.swift
//  KataKita
//
//  Created by Lisandra Nicoline on 18/10/24.
//

import SwiftUI

class AACKamarMandiViewModel: ObservableObject {
    @Published var cards: [[Card]] = []

    init() {
        loadCardsData()
    }

    // Function to load the data and convert it to Card models
    func loadCardsData() {
        let rawData = [
            [("saya", "saya", "#FFEBAF", "#000000"), ("kamu", "kamu", "#FFEBAF", "#000000"), ("dia", "dia", "#FFEBAF", "#000000"), ("kita", "kita", "#FFEBAF", "#000000"), ("ibu", "ibu", "#FFEBAF", "#000000"), ("ayah", "ayah", "#FFEBAF", "#000000")],
            [("apa", "apa", "#A77DFF", "#000000"), ("dimana", "dimana", "#A77DFF", "#000000"), ("kapan", "kapan", "#A77DFF", "#000000"), ("siapa", "siapa", "#A77DFF", "#000000")],
            [("mau", "mau", "#FFB0C7", "#000000"), ("iya", "iya", "#FFB0C7", "#000000"), ("tidak", "tidak", "#FFB0C7", "#000000"), ("selesai", "selesai", "#FFB0C7", "#000000"), ("tolong", "tolong", "#FFB0C7", "#000000")],
            [("toilet", "pipis", "#CFF0C8", "#000000"), ("toilet", "pup", "#CFF0C8", "#000000"), ("mandi", "mandi", "#CFF0C8", "#000000"), ("sikat gigi", "menyikat gigi", "#CFF0C8", "#000000"), ("cucitangan", "Cuci tangan", "#CFF0C8", "#000000"), ("ambil", "ambil", "#CFF0C8", "#000000")],
            [("keras", "keras", "#D4F3FF", "#000000"), ("berat", "berat", "#D4F3FF", "#000000"), ("panas", "panas", "#D4F3FF", "#000000"), ("dingin", "dingin", "#D4F3FF", "#000000")],
            [("shampo", "sampo", "#F2B95C", "#000000"), ("sabun", "sabun", "#F2B95C", "#000000"), ("odol pasta gigi", "pasta gigi", "#F2B95C", "#000000"), ("odol sikat gigi", "sikat gigi", "#F2B95C", "#000000"), ("handuk", "handuk", "#F2B95C", "#000000"), ("shower", "shower", "#F2B95C", "#000000")],
            [("baju", "baju", "#F2B95C", "#000000"), ("celana pendek", "celana", "#F2B95C", "#000000"), ("air", "air", "#F2B95C", "#000000"), ("gelas air", "gelas", "#F2B95C", "#000000"), ("Lemari", "lemari", "#F2B95C", "#000000")],
            [("di", "di", "#FFFFFF", "#000000"), ("ke", "ke", "#FFFFFF", "#000000"), ("dan", "dan", "#FFFFFF", "#000000")],
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
        // Create a new category for this card (you can adjust this logic)
        let category = Category(name: "New Category", color: backgroundColor, fontColor: "#000000") // Default font color

        // Create the new card
        let newCard = Card(icon: icon, name: text, category: category)
                cards.append([newCard])
                print("Added card: \(newCard)")

        // Add the new card to the first row for simplicity (adjust this logic as needed)
        if !cards.isEmpty {
            // Adding to the first row, modify if necessary
            cards[0].append(newCard)
        } else {
            // If no rows exist, create the first row with the new card
            cards.append([newCard])
        }
        
    }
}
