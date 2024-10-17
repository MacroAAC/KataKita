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
                            image: "",
                            ruangan: Ruangan(id: UUID(), name: "KamarMandi"),
                            sequence: [
                                Step(image: "", description: "Buka celana"),
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
                            image: "",
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
                            image: "",
                            ruangan: Ruangan(id: UUID(), name: "RuangMakan"),
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
                        ),
                        Activity(
                            id: UUID(),
                            name: "Belajar",
                            image: "",
                            ruangan: Ruangan(id: UUID(), name: "RuangBelajar"),
                            sequence: [
                                Step(image: "", description: "Siapkan buku dan alat tulis"),
                                        Step(image: "", description: "Cari tempat yang nyaman untuk belajar"),
                                        Step(image: "", description: "Buka buku pelajaran"),
                                        Step(image: "", description: "Mulai membaca atau menulis catatan"),
                                        Step(image: "", description: "Jika perlu, gunakan laptop atau perangkat lain"),
                                        Step(image: "", description: "Fokus selama 25-30 menit"),
                                        Step(image: "", description: "Ambil istirahat singkat")
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
