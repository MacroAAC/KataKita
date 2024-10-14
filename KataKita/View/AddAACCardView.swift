import SwiftUI
import PhotosUI

// MARK: - AddButtonView
struct AddButtonView: View {
    @State private var textToSpeak: String = ""
    @State private var showingAddImageView = false
    @State private var selectedImage: UIImage? = nil
    @Binding var navigateTooAddImage: Bool
    @Binding var selectedSymbolImage: String // Track the selected symbol
    @Binding var navigateFromSymbols: Bool
    @Binding var navigateFromImage: Bool
    @Binding var selectedSymbolName: String
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if navigateTooAddImage {
                        TextField("Text to Speak", text: $textToSpeak)
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
                        .background(
                            NavigationLink(
                                destination: AddImageView(selectedImage: $selectedImage),
                                isActive: $showingAddImageView
                            ) {
                                EmptyView()
                            }
                        )
                    } else {
                        if navigateFromSymbols {
                            TextField("Text to Speak", text: $selectedSymbolName)
                            Button(action: {
                                showingAddImageView = true
                            }) {
                                VStack {
                                    Text("Which meaning?")
                                        .foregroundColor(Color(red: 60 / 255, green: 60 / 255, blue: 67 / 255))
                                        .font(.body)
                                    CustomButton(
                                        icon: selectedSymbolImage,
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
                            Button(action: {
                                showingAddImageView = true
                            }) {
                                VStack {
                                    Text("Which meaning?")
                                        .foregroundColor(Color(red: 60 / 255, green: 60 / 255, blue: 67 / 255))
                                        .font(.body)
                                    CustomButton(
                                        icon: selectedSymbolImage,
                                        width: 100, height: 100, font: 40,
                                        iconWidth: 50, iconHeight: 50, bgColor: "#000000",
                                        bgTransparency: 1.0, fontColor: "#ffffff",
                                        fontTransparency: 1.0, cornerRadius: 20,
                                        isSystemImage: true
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Add Button", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    // Handle done action
                }
            )
        }
    }
}



// MARK: - SymbolsView
import SwiftUI

struct SymbolsView: View {
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
                    destination: AddButtonView(navigateTooAddImage: .constant(false), selectedSymbolImage: $selectedSymbol, navigateFromSymbols: .constant(true), navigateFromImage: .constant(false), selectedSymbolName: $selectedSymbol),
                    isActive: $navigateToAddButton
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Add Symbols", displayMode: .inline)
        }
    }
}





// MARK: - AddImageView
struct AddImageView: View {
    @Binding var selectedImage: UIImage?
    @State private var showImage: Bool = true
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showingSymbolsView = false
    
    var body: some View {
        Form {
            Section {
                // Symbols Placeholder
                Button(action: {
                    showingSymbolsView = true
                }) {
                    HStack {
                        Text("Symbols")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .background(
                    NavigationLink(
                        destination: SymbolsView(),
                        isActive: $showingSymbolsView
                    ) {
                        EmptyView()
                    }
                )
                
                // Choose Image
                Button("Choose Image...") {
                    showImagePicker = true
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $selectedImage)
                }
                
                // Take Photo
                Button("Take Photo...") {
                    showCamera = true
                }
                .sheet(isPresented: $showCamera) {
                    ImagePicker(sourceType: .camera, image: $selectedImage)
                }
                
                // Toggle to show image
                Toggle(isOn: $showImage) {
                    Text("Show Image")
                }
            }
        }
        .navigationBarTitle("Add Image", displayMode: .inline)
        .navigationBarItems(
            trailing: Button("Done") {
                // Handle done action
            }
        )
    }
}

// MARK: - ImagePicker Helper
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Previews
struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(navigateTooAddImage: .constant(true), selectedSymbolImage: .constant("people"), navigateFromSymbols: .constant(false), navigateFromImage: .constant(false), selectedSymbolName: .constant("people")) // Provide a sample binding
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView(selectedImage: .constant(nil))
    }
}

struct AddSymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsView()
    }
}
