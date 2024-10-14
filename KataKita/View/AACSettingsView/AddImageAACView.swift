import SwiftUI
import PhotosUI


// MARK: - AddImageView
struct AddImageAACView: View {
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
                        destination: AddSymbolsAACView(),
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
