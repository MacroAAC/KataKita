import SwiftUI

struct AddButtonAACView: View {
    @State private var textToSpeak: String = ""
    @State private var showingAddImageView = false
    
    @Binding var navigateTooAddImage: Bool
    @Binding var selectedSymbolImage: String // Track the selected symbol
    @Binding var navigateFromSymbols: Bool
    @Binding var navigateFromImage: Bool
    @Binding var selectedSymbolName: String
    @Binding var selectedImage: UIImage?
    
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
                                destination: AddImageAACView(),
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
                                    ImageCard(
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
                            TextField("Text to Speak", text: $selectedSymbolName)
                            Button(action: {
                                showingAddImageView = true
                            }) {
                                VStack {
                                    
                                    // Here we check if an image was selected and display it
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
            selectedSymbolName: $selectedSymbolName,
            selectedImage: .constant(nil)
        )
    }
}
