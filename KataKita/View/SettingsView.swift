import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            Form {
                // Profil Pengguna Section
                Section(header: Text("PROFIL PENGGUNA")) {
                    HStack {
                        Text("testsubject@icloud.com")
                        Spacer()
                        NavigationLink(destination: DetailView()) {
                            Text("Detail")
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Text("Warna Kulit")
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                        NavigationLink(destination: DetailView()) {
                            
                        }
                    }
                    HStack {
                        Text("Bahasa")
                        Spacer()
                        NavigationLink(destination: DetailView()) {
                            Text("Detail")
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
                            Text("Detail")
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Text("Pengaturan Papan AAC")
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                        NavigationLink(destination: DetailView()) {
                            
                        }
                    }
                    HStack {
                        Text("Pengaturan Urutan Aktifitas")
                        Spacer()
                        NavigationLink(destination: DetailView()) {
                            Text("Detail")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Pengaturan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        // Action for Done button
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        // Action for Cancel button
                    }
                }
            }
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
