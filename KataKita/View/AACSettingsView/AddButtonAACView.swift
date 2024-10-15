import SwiftUI
import CoreLocation
import UIKit
struct AddButtonAACView: View {
    @Binding var textToSpeak: String
    @State private var showingAddImageView = false
    @State private var navigateToCardList = false  // State variable to control navigation
    
    @Binding var navigateTooAddImage: Bool
    @Binding var navigateFromSymbols: Bool
    @Binding var navigateFromImage: Bool
    @Binding var selectedImageName: String
    @Binding var selectedImage: UIImage?

    @ObservedObject var cardViewModel: CardViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if navigateTooAddImage {
                        TextField("Text to Speak", text: $textToSpeak)
                        NavigationLink(
                            destination: AddImageAACView(textToSpeak: $textToSpeak),
                            isActive: $showingAddImageView
                        ) {
                            Button(action: {
                                showingAddImageView = true
                            }) {
                                HStack {
                                    Text("Add Image")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    } else {
                        if navigateFromSymbols {
                            TextField("Text to Speak", text: $selectedImageName)
                            Button(action: {
                                showingAddImageView = true
                            }) {
                                VStack {
                                    Text("Which meaning?")
                                        .foregroundColor(Color(red: 60 / 255, green: 60 / 255, blue: 67 / 255))
                                        .font(.body)
                                    ImageCard(
                                        icon: selectedImageName,
                                        width: 100, height: 100, font: 40,
                                        iconWidth: 50, iconHeight: 50, bgColor: "#000000",
                                        bgTransparency: 1.0, fontColor: "#ffffff",
                                        fontTransparency: 1.0, cornerRadius: 20,
                                        isSystemImage: true
                                    )
                                }
                            }
                        }

                        if navigateFromImage {
                            TextField("Text to Speak", text: $selectedImageName)
                            Button(action: {
                                showingAddImageView = true
                            }) {
                                VStack {
                                    if let selectedImage = selectedImage {
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: CGFloat(100), height: CGFloat(100))
                                            .padding(.bottom, 8)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Add Button", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    // Save selectedImageName and selectedImage to the ViewModel
                    let newCard = Card(
                        id: UUID(),
                        name: selectedImageName,
                        image: selectedImage ?? UIImage(), // Use a default image if none is selected
                        category: cardViewModel.categories.first!  // Example: add to the first category
                    )
                    cardViewModel.cards.append(newCard)

                    // Navigate to the card list after saving the card
                    navigateToCardList = true
                }
            )
            // Navigate to the CardListView
            .background(
                NavigationLink(
                    destination: CardListView(cardViewModel: cardViewModel),
                    isActive: $navigateToCardList
                ) {
                    EmptyView()
                }
            )
        }
    }
}



struct AddButtonAACView_Previews: PreviewProvider {
    @State static var navigateTooAddImage = true
    @State static var selectedSymbolImage = "star.fill"
    @State static var navigateFromSymbols = false
    @State static var navigateFromImage = false
    @State static var selectedImageName = ""
    @State static var textToSpeak = ""

    static var previews: some View {
        AddButtonAACView(
            textToSpeak: $textToSpeak,
            navigateTooAddImage: $navigateTooAddImage,
            navigateFromSymbols: $navigateFromSymbols,
            navigateFromImage: $navigateFromImage,
            selectedImageName: $selectedImageName,
            selectedImage: .constant(nil),
            cardViewModel: CardViewModel()  // Pass the ViewModel here
        )
    }
}

struct CardListView: View {
    @ObservedObject var cardViewModel: CardViewModel  // ViewModel to get the list of cards
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cardViewModel.cards) { card in
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
            .navigationBarTitle("Card List", displayMode: .inline)
        }
    }
}

