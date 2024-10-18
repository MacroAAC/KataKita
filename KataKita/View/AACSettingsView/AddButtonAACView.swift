import SwiftUI

struct AddButtonAACView: View {
    @ObservedObject var viewModel: AACRuangMakanViewModel
    @State private var textToSpeak: String = ""
    @State private var showingAddImageView = false
    @State private var navigatesFromImage = false
    @State private var navigateToCekVMView = false

    let availableAssets = ["delete", "home", "trash", "settings", "ball", "plusimage", "air"]
    
    @Binding var navigateTooAddImage: Bool
    @Binding var selectedSymbolImage: String
    @Binding var navigateFromSymbols: Bool
    @Binding var navigateFromImage: Bool
    @Binding var selectedSymbolName: String
    @Binding var selectedImage: UIImage?
    
    var matchedAsset: String? {
        availableAssets.contains(textToSpeak.lowercased()) ? textToSpeak.lowercased() : nil
    }
    
    @Binding var categoryColor: String
    @Binding var selectedColumnIndex: [Card]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if !navigateFromImage {
                        TextField("Tambah Kata Baru", text: $textToSpeak)
                            .onChange(of: textToSpeak) { newValue in
                                textToSpeak = newValue.lowercased()
                                navigatesFromImage = false
                            }
                    }
                }
                
                if navigateFromImage {
                    TextField("Tambah Kata Baru", text: $selectedSymbolName)
                    Button(action: {
                        showingAddImageView = true
                    }) {
                        VStack {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                }
                
                if !textToSpeak.isEmpty {
                    VStack(alignment: .leading) {
                        if !navigatesFromImage {
                            Text("Which meaning?")
                                .foregroundColor(Color(red: 60 / 255, green: 60 / 255, blue: 67 / 255))
                                .font(.body)
                        }
                        
                        HStack {
                            CustomButton(
                                icon: matchedAsset ?? "",
                                text: matchedAsset == nil ? textToSpeak : "",
                                width: 100,
                                height: 100,
                                font: 20,
                                iconWidth: 50,
                                iconHeight: 50,
                                bgColor: categoryColor,
                                bgTransparency: 1.0,
                                fontColor: "#000000",
                                fontTransparency: 1.0,
                                cornerRadius: 20,
                                isSystemImage: false,
                                action: {
                                    navigatesFromImage = true
                                }
                            )
                            
                            CustomButton(
                                icon: "plus",
                                width: 100,
                                height: 100,
                                font: 40,
                                iconWidth: 50,
                                iconHeight: 50,
                                bgColor: "#000000",
                                bgTransparency: 1.0,
                                fontColor: "#696767",
                                fontTransparency: 1.0,
                                cornerRadius: 20,
                                isSystemImage: true,
                                action: {
                                    showingAddImageView = true
                                }
                            )
                            .opacity(navigatesFromImage ? 0 : 1)
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $showingAddImageView) {
                AddImageAACView(viewModel: viewModel)
            }
            .navigationBarItems(
                trailing: Button("Done") {
                    print("Done button pressed") // Debugging statement
                    handleDoneAction()
                    navigateToCekVMView = true
                }
            )
                
            NavigationLink(destination: cekVMview(viewModel: viewModel), isActive: $navigateToCekVMView) {
                EmptyView()
            }

        }
        .onAppear {
            print("View appeared, showingAddImageView: \(showingAddImageView)")
            
            print("Current category color: \(categoryColor)")
            
        }
    }
    
    private func handleDoneAction() {
        // Fetch icon, text, and color from input
        let icon = matchedAsset ?? "" // Use matchedAsset if available, or an empty string
        let text = textToSpeak // Text entered by the user
        let color = categoryColor // Background color of the category

        // Debugging statement to check values before saving
        print("Handling done action: Icon: \(icon), Text: \(text), Background Color: \(color)")

        // Call the function to save data to ViewModel
        saveButtonData(icon: icon, text: text, backgroundColor: color)
    }


    private func saveButtonData(icon: String, text: String, backgroundColor: String) {
        // Menambahkan kartu baru ke ViewModel
        viewModel.addCard(icon: icon, text: text, backgroundColor: backgroundColor)
        
        // Debugging statement setelah menyimpan data
        print("Saved card data: Icon: \(icon), Text: \(text), Background Color: \(backgroundColor)")
    }
}


//struct AddButtonAACView_Previews: PreviewProvider {
//    @State static var navigateTooAddImage = true
//    @State static var selectedSymbolImage = "star.fill"
//    @State static var navigateFromSymbols = false
//    @State static var navigateFromImage = false
//    @State static var selectedSymbolName = ""
//
//    static var previews: some View {
//        AddButtonAACView(
//            navigateTooAddImage: $navigateTooAddImage,
//            selectedSymbolImage: $selectedSymbolImage,
//            navigateFromSymbols: $navigateFromSymbols,
//            navigateFromImage: $navigateFromImage,
//            selectedSymbolName: $selectedSymbolName,
//            selectedImage: .constant(nil)
//        )
//    }
//}
