import SwiftUI

struct AddSymbolsAACView: View {
    @ObservedObject var viewModel = CardViewModel()
    @State private var searchText: String = ""
    @State private var navigateToAddButton = false
    @State private var selectedSymbol: String = "" // Store selected symbol

    var filteredSymbols: [String] {
        let allSymbols = viewModel.cards.map { $0.name } // Extracting card names as symbols
        if searchText.isEmpty {
            return allSymbols
        } else {
            return allSymbols.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // List of Symbols and Cards
                List {
                    // Displaying symbols from card names
                    Section(header: Text("Symbols")) {
                        ForEach(viewModel.cards) { card in
                            Button {
                                selectedSymbol = card.name // Set the selected symbol
                                navigateToAddButton = true // Trigger navigation
                            } label: {
                                HStack {
                                    Image(uiImage: card.image)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    VStack(alignment: .leading) {
                                        Text(card.name)
                                            .font(.headline)
                                        Text("Category: \(card.category.name)")
                                            .font(.subheadline)
                                            .foregroundColor(Color(card.category.color))
                                    }
                                }
                            }
                        }
                    }
                    
                }
                
                // Navigation to AddButtonView
                NavigationLink(
                    destination: AddButtonAACView(
                        navigateTooAddImage: .constant(false),
                        selectedSymbolImage: $selectedSymbol,
                        navigateFromSymbols: .constant(true),
                        navigateFromImage: .constant(false),
                        selectedSymbolName: $selectedSymbol,
                        selectedImage: .constant(nil)
                    ),
                    isActive: $navigateToAddButton
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Add Symbols", displayMode: .inline)
        }
    }
}

// MARK: - Preview
struct AddSymbolsAACView_Previews: PreviewProvider {
    static var previews: some View {
        AddSymbolsAACView()
    }
}
