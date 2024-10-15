import SwiftUI
import PhotosUI

struct AddImageAACView: View {
    @State var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showingSymbolsView = false
    @State private var navigateToAddButton = false
    @State private var selectedSymbol = UIImage()
    @State private var showAlert = false  // State to control the alert presentation
    @ObservedObject var viewModel = CardViewModel()
    @Binding var textToSpeak: String
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button(action: {
                        showingSymbolsView = true
                    }) {
                        HStack {
                            Text("Collections")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    .background(
                        NavigationLink(
                            destination: AddCollectionAACView(textToSpeak: .constant("")),
                            isActive: $showingSymbolsView
                        ) {
                            EmptyView()
                        }
                    )

                    Button("Choose Image...") {
                        showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $selectedImage)
                    }

                    Button("Take Photo...") {
                        showCamera = true
                    }
                    .sheet(isPresented: $showCamera) {
                        ImagePicker(sourceType: .camera, image: $selectedImage)
                    }

                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(20)
                    } else {
                        Text("No image selected")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationBarTitle("Add Image", displayMode: .inline)
        .navigationBarItems(
            trailing: Button("Done") {
                if let image = selectedImage {
                    selectedSymbol = image  // Set the selected image to be passed
                    navigateToAddButton = true  // Trigger navigation
                }
            }
        )
        .background(
            NavigationLink(
                destination: AddButtonAACView(
                    textToSpeak: $textToSpeak, navigateTooAddImage: .constant(false),
                    navigateFromSymbols: .constant(false),
                    navigateFromImage: .constant(true),
                    selectedImageName: .constant(""),
                    selectedImage: $selectedImage, cardViewModel: viewModel
                ),
                isActive: $navigateToAddButton
            ) {
                EmptyView()
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
                print("Image selected: \(uiImage)")  // Debugging purpose
            } else {
                print("No image found")
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Preview
struct AddImageAACView_Previews: PreviewProvider {
    @State static var textToSpeak = "This is the alert message"
    
    static var previews: some View {
        NavigationStack {
            AddImageAACView(textToSpeak: $textToSpeak)
        }
    }
}
