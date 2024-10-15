import SwiftUI

struct AddCollectionAACView: View {
    @ObservedObject var viewModel = CardViewModel()
    @State private var searchText: String = ""
    @State private var navigateToAddButton = false
    @State private var selectedSymbol: String = ""
    @Binding var textToSpeak: String

    // Filtered list of cards based on the search text
    var filteredCards: [Card] {
        if searchText.isEmpty {
            return viewModel.cards
        } else {
            return viewModel.cards.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // List of filtered cards using the updated CardListView style
                List {
                    ForEach(filteredCards) { card in
                        Button {
                            selectedSymbol = card.name // Set the selected symbol
                            navigateToAddButton = true // Trigger navigation
                        } label: {
                            HStack {
                                Image(uiImage: card.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .padding(.trailing, 8)

                                Text(card.name)
                                    .font(.headline)
                            }
                        }
                    }
                }

                // Navigation to AddButtonView
                NavigationLink(
                    destination: AddButtonAACView(
                        textToSpeak: $textToSpeak,
                        navigateTooAddImage: .constant(false),
                        navigateFromSymbols: .constant(true),
                        navigateFromImage: .constant(false),
                        selectedImageName: $selectedSymbol,
                        selectedImage: .constant(nil),
                        cardViewModel: viewModel
                    ),
                    isActive: $navigateToAddButton
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Add Collection", displayMode: .inline)
        }
    }
}

// MARK: - Preview
struct AddCollectionAACView_Previews: PreviewProvider {
    @State static var textToSpeak = ""

    static var previews: some View {
        AddCollectionAACView(textToSpeak: $textToSpeak)
    }
}
