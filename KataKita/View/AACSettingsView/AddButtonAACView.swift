import SwiftUI

struct AddButtonAACView: View {
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
                                destination: AddImageAACView(selectedImage: $selectedImage),
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

struct AddButtonAACView_Previews: PreviewProvider {
    @State static var navigateTooAddImage = true
    @State static var selectedSymbolImage = "star.fill"
    @State static var navigateFromSymbols = false
    @State static var navigateFromImage = false
    @State static var selectedSymbolName = ""

    static var previews: some View {
        AddButtonAACView(
            navigateTooAddImage: $navigateTooAddImage,
            selectedSymbolImage: $selectedSymbolImage,
            navigateFromSymbols: $navigateFromSymbols,
            navigateFromImage: $navigateFromImage,
            selectedSymbolName: $selectedSymbolName
        )
    }
}
