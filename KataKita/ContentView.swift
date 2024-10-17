//
//  ContentView.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 08/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(ScheduleManager.self) private var scheduleManager
    @Environment(ActivitiesManager.self) private var activitiesManager
    
    @Query private var items: [Item]

    var body: some View {
        DailyActivityView()
            .onAppear {
                // Dummy Data
                self.scheduleManager.schedules = [
                    Schedule(id: UUID(), day: .MONDAY([])),
                    Schedule(id: UUID(), day: .TUESDAY([])),
                    Schedule(id: UUID(), day: .WEDNESDAY([])),
                    Schedule(id: UUID(), day: .THURSDAY([])),
                    Schedule(id: UUID(), day: .FRIDAY([])),
                    Schedule(id: UUID(), day: .SATURDAY([])),
                    Schedule(id: UUID(), day: .SUNDAY([]))
                ]
                
                self.activitiesManager.activities = [
                    Activity(
                        id: UUID(),
                        name: "Memasang Pembalut",
                        image: "",
                        sequence: [
                            Step(image: "", description: "Buka pembalut baru"),
                            Step(image: "", description: "Lepas perekat pada bagian sayap"),
                            Step(image: "", description: "Masukkan pembalut pada celana dalam"),
                            Step(image: "", description: "Rekatkan pembalut pada celana dalam"),
                            Step(image: "", description: "Buang ke tempat sampah"),
                            Step(image: "", description: "Ambil sabun"),
                            Step(image: "", description: "Cuci tangan dengan sabun"),
                            Step(image: "", description: "Selesai")
                        ]
                    ),
                    Activity(
                        id: UUID(),
                        name: "Mandi",
                        image: "",
                        sequence: [
                            Step(image: "", description: "Siapkan Handuk"),
                            Step(image: "", description: "Lepas semua baju yang dikenakan"),
                            Step(image: "", description: "Siram seluruh tubuh menggunakan gayung"),
                            Step(image: "", description: "Bersihkan badan menggunakan sabun"),
                            Step(image: "", description: "Siram kembali seluruh tubuh hingga bersih dari sabun"),
                            Step(image: "", description: "Ambil pasta gigi dan sikat gigi"),
                            Step(image: "", description: "Gosok gigimu hingga bersih"),
                            Step(image: "", description: "Kumur-kumur untuk menghilangkan busa pada mulutmu"),
                            Step(image: "", description: "Keringkan badanmu menggunakan handuk"),
                            Step(image: "", description: "Pakai bajumu yang bersih")
                        ]
                    ),
                    Activity(
                        id: UUID(),
                        name: "Makan",
                        image: "",
                        sequence: [
                            Step(image: "", description: "Cuci tangan"),
                            Step(image: "", description: "Ambil sendok, garpu, dan piring"),
                            Step(image: "", description: "Duduk di meja makan"),
                            Step(image: "", description: "Ambil nasi secukupnya"),
                            Step(image: "", description: "Ambil lauk secukupnya"),
                            Step(image: "", description: "Berdoa sebelum makan"),
                            Step(image: "", description: "Makan sampai habis"),
                            Step(image: "", description: "Minum air putih setelah makan"),
                            Step(image: "", description: "Cuci sendok, garpu dan piring yang kotor"),
                            Step(image: "", description: "Kembalikan sendok, garpu, dan piring pada tempatnya")
                        ]
                    )
                ]
            }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
