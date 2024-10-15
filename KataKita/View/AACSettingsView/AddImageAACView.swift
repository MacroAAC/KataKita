import SwiftUI
import PhotosUI

struct AddImageAACView: View {
    @Binding var selectedImage: UIImage?
    @State private var showImage: Bool = true
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showingSymbolsView = false
    @State private var useSymbol: Bool = false

    var body: some View {
        Form {
            Section {

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
                
                // Display the image or symbol
                if showImage {
                    if useSymbol {
                        // Show symbol placeholder
                        ImageCard(icon: "star", width: 100, height: 100, font: 40, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20, isSystemImage: true)
                    } else if let image = selectedImage {
                        // Show the selected image
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(20)
                    }
                }
            }
        }
        .navigationBarTitle("Add Image", displayMode: .inline)
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

// MARK: - Preview
struct AddImageAACView_Previews: PreviewProvider {
    @State static var selectedImage: UIImage? = nil

    static var previews: some View {
        NavigationStack {
            AddImageAACView(selectedImage: $selectedImage)
        }
    }
}
