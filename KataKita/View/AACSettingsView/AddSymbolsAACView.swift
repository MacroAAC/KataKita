import SwiftUI

struct AddSymbolsAACView: View {
    @State private var searchText: String = ""
    @State private var symbols = ["sleep", "wake", "rest"] // Example data
    @State private var navigateToAddButton = false
    @State private var selectedSymbol: String = "" // Store selected symbol

    var filteredSymbols: [String] {
        if searchText.isEmpty {
            return symbols
        } else {
            return symbols.filter { $0.contains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // List of Symbols
                List {
                    ForEach(filteredSymbols, id: \.self) { symbol in
                        Button {
                            selectedSymbol = symbol // Set the selected symbol
                            navigateToAddButton = true // Trigger navigation
                        } label: {
                            HStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text(symbol)
                            }
                        }
                    }
                }
                
                // Navigation to AddButtonView
                NavigationLink(
                    destination: AddButtonAACView(navigateTooAddImage: .constant(false), selectedSymbolImage: $selectedSymbol, navigateFromSymbols: .constant(true), navigateFromImage: .constant(false), selectedSymbolName: $selectedSymbol),
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
