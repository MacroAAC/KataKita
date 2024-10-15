import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = CardViewModel()
    var body: some View {
        NavigationStack {
            Form {
                // Profil Pengguna Section
                Section(header: Text("PROFIL PENGGUNA")) {
                    HStack {
                        Text("testsubject@icloud.com")
                        Spacer()
                        //                        NavigationLink(destination: DetailView()) {
                        //                            Text("Detail")
                        //                                .foregroundColor(.gray)
                        //                        }
                        HStack {
                            Text("Detail")
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Text("Warna Kulit")
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                    HStack {
                        Text("Bahasa")
                        Spacer()
                        //                        NavigationLink(destination: DetailView()) {
                        //                            Text("Detail")
                        //                                .foregroundColor(.gray)
                        //                        }
                        HStack {
                            Text("Detail")
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // Pengaturan Kataloka Section
                Section(header: Text("PENGATURAN KATALOKA")) {
                    HStack {
                        Text("Pengaturan Aktivitas Harian")
                        Spacer()
                        NavigationLink(destination: DetailView()) {
                            HStack{
                                Spacer()
                                Text("Detail")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    HStack {
                        Text("Buat Kartu Papan AAC")
                        Spacer()
                        NavigationLink(destination: AddButtonAACView(textToSpeak: .constant(""), navigateTooAddImage: .constant(true), navigateFromSymbols: .constant(false), navigateFromImage: .constant(false), selectedImageName: .constant("people"), selectedImage: .constant(nil), cardViewModel: viewModel)) {
                            HStack{
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    HStack {
                        Text("Pengaturan Urutan Aktifitas")
                        Spacer()
                        //                        NavigationLink(destination: DetailView()) {
                        //                            HStack{
                        //                                Spacer()
                        //                                Text("Detail")
                        //                                    .foregroundColor(.gray)
                        //                            }
                        //                        }
                        HStack {
                            Text("Detail")
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Pengaturan")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail Page")
    }
}

#Preview {
    SettingsView()
}
