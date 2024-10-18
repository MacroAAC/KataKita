//
//  KataKitaApp.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 08/10/24.
//

import SwiftUI
import SwiftData

extension Date {
    func dayNumberOfWeek() -> Int {
        return (Calendar.current.dateComponents([.weekday], from: self).weekday ?? 1) - 1
    }
}

public extension Collection where Indices.Iterator.Element == Index {
    subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : "" as! Self.Element
    }
}

@main
struct KataKitaApp: App {
    @State private var scheduleManager = ScheduleManager()
    @State private var activitiesManager = ActivitiesManager()
    @State private var stateManager = StateManager()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomePageView()
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
                            name: "Pipis",
                            image: "TOILET",
                            ruangan: Ruangan(id: UUID(), name: "KamarMandi"),
                            sequence: [
                                Step(image: "CELANA PENDEK", description: "Buka celana"),
                                Step(image: "", description: "Duduk di toilet"),
                                Step(image: "", description: "Buang air kecil"),
                                Step(image: "", description: "Siram toilet"),
                                Step(image: "", description: "Ambil sabun"),
                                Step(image: "", description: "Cuci tangan dengan sabun"),
                                Step(image: "", description: "Keringkan tangan")
                            ]
                        ),
                        Activity(
                            id: UUID(),
                            name: "Mandi",
                            image: "BAK MANDI",
                            ruangan: Ruangan(id: UUID(), name: "KamarMandi"),
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
                            image: "MAKAN",
                            ruangan: Ruangan(id: UUID(), name: "RuangMakan"),
                            sequence: [
                                Step(image: "", description: "Ambil piring"),
                                Step(image: "", description: "Ambil sendok dan garpu"),
                                Step(image: "", description: "Duduk di meja makan"),
                                Step(image: "", description: "Berdoa sebelum makan"),
                                Step(image: "", description: "Mulai makan sampai habis"),
                                Step(image: "", description: "Minum air putih setelah makan"),
                                Step(image: "", description: "Lap mulut setelah habis makan"),
                                Step(image: "", description: "Kembalikan sendok, garpu, dan piring pada tempatnya")
                            ]
                        ),
                        Activity(
                            id: UUID(),
                            name: "Cuci tangan",
                            image: "",
                            ruangan: Ruangan(id: UUID(), name: "KamarMandi"),
                            sequence: [
                                        Step(image: "", description: "Buka keran air"),
                                        Step(image: "", description: "Basahi tangan dengan air"),
                                        Step(image: "", description: "Ambil sabun"),
                                        Step(image: "", description: "Gosok sabun di tangan kiri"),
                                        Step(image: "", description: "Gosok sabun di tangan kanan"),
                                        Step(image: "", description: "Bilas sabun dengan air"),
                                        Step(image: "", description: "Keringkan tangan")
                            ]
                        ),
                        Activity(
                            id: UUID(),
                            name: "Cuci Piring",
                            image: "MEJA BELAJAR",
                            ruangan: Ruangan(id: UUID(), name: "RuangMakan"),
                            sequence: [
                                        Step(image: "", description: "Ambil piring dan sendok garpu kotor"),
                                        Step(image: "", description: "Basahilah dengan air"),
                                        Step(image: "", description: "Ambil spon dan beri sabun"),
                                        Step(image: "", description: "Gosok piring dan sendok garpu dengan sabun dan spon"),
                                        Step(image: "", description: "Jika perlu, gunakan laptop atau perangkat lain"),
                                        Step(image: "", description: "Bilas semua dengan air bersih"),
                                        Step(image: "", description: "Letakkan di tempat pengeringan")
                            ]
                        ),
                        Activity(
                            id: UUID(),
                            name: "Mewarnai",
                            image: "MEJA BELAJAR",
                            ruangan: Ruangan(id: UUID(), name: "RuangBelajar"),
                            sequence: [
                                        Step(image: "", description: "Ambil buku dan pewarna"),
                                        Step(image: "", description: "Duduk di meja belajar"),
                                        Step(image: "", description: "Buka buku dan siapkan alat pewarna"),
                                        Step(image: "", description: "Mulai mewarnai tugas yang diberikan"),
                                        Step(image: "", description: "Setelah selesai, rapikan alat mewarnai"),
                                        Step(image: "", description: "Kembalikan peralatan pada tempatnya")
                            ]
                        )
                    ]
                }
        }
        .modelContainer(sharedModelContainer)
        .environment(scheduleManager)
        .environment(activitiesManager)
        .environment(stateManager)
    }
}
