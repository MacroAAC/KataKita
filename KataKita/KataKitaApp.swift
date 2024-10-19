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

func resolveIcon(for iconName: String) -> String {
    if let _ = UIImage(named: iconName) {
        return iconName
    } else if let _ = UIImage(named: iconName.uppercased()) {
        return iconName.uppercased()
    } else if let _ = UIImage(named: iconName.lowercased()) {
        return iconName.lowercased()
    } else {
        // Fallback option if no icon is found
        return "defaultIcon" // You can define a default icon
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
                            image: resolveIcon(for: "TOILET"),
                            ruangan: Ruangan(id: UUID(), name: "KamarMandi"),
                            sequence: [
                                Step(image: resolveIcon(for: "CELANA PENDEK"), description: "Buka celana"),
                                Step(image: resolveIcon(for: ""), description: "Duduk di toilet"),
                                Step(image: resolveIcon(for: ""), description: "Buang air kecil"),
                                Step(image: resolveIcon(for: ""), description: "Bersihkan daerah kemaluan pakai tisu"),
                                Step(image: resolveIcon(for: ""), description: "Pakai celana kembali"),
                                Step(image: resolveIcon(for: ""), description: "Siram toilet"),
                                Step(image: resolveIcon(for: ""), description: "Ambil sabun"),
                                Step(image: resolveIcon(for: ""), description: "Cuci tangan dengan sabun"),
                                Step(image: resolveIcon(for: ""), description: "Keringkan tangan")
                            ]
                        ),
//                        Activity(
//                            id: UUID(),
//                            name: "Mandi",
//                            image: resolveIcon(for: "BAK MANDI"),
//                            ruangan: Ruangan(id: UUID(), name: "KamarMandi"),
//                            sequence: [
//                                Step(image: resolveIcon(for: ""), description: "Siapkan Handuk"),
//                                Step(image: resolveIcon(for: ""), description: "Lepas semua baju yang dikenakan"),
//                                Step(image: resolveIcon(for: ""), description: "Siram seluruh tubuh menggunakan gayung"),
//                                Step(image: resolveIcon(for: ""), description: "Bersihkan badan menggunakan sabun"),
//                                Step(image: resolveIcon(for: ""), description: "Siram kembali seluruh tubuh hingga bersih dari sabun"),
//                                Step(image: resolveIcon(for: ""), description: "Ambil pasta gigi dan sikat gigi"),
//                                Step(image: resolveIcon(for: ""), description: "Gosok gigimu hingga bersih"),
//                                Step(image: resolveIcon(for: ""), description: "Kumur-kumur untuk menghilangkan busa pada mulutmu"),
//                                Step(image: resolveIcon(for: ""), description: "Keringkan badanmu menggunakan handuk"),
//                                Step(image: resolveIcon(for: ""), description: "Pakai bajumu yang bersih")
//                            ]
//                        ),
                        Activity(
                            id: UUID(),
                            name: "Makan",
                            image: resolveIcon(for: "MAKAN"),
                            ruangan: Ruangan(id: UUID(), name: "RuangMakan"),
                            sequence: [
                                Step(image: resolveIcon(for: ""), description: "Ambil piring"),
                                Step(image: resolveIcon(for: ""), description: "Ambil sendok dan garpu"),
                                Step(image: resolveIcon(for: ""), description: "Duduk di meja makan"),
                                Step(image: resolveIcon(for: ""), description: "Berdoa sebelum makan"),
                                Step(image: resolveIcon(for: ""), description: "Mulai makan sampai habis"),
                                Step(image: resolveIcon(for: "MINUM"), description: "Minum air putih setelah makan"),
                                Step(image: resolveIcon(for: ""), description: "Lap mulut setelah habis makan"),
                                Step(image: resolveIcon(for: ""), description: "Kembalikan sendok, garpu, dan piring pada tempatnya")
                            ]
                        ),
                        Activity(
                            id: UUID(),
                            name: "Cuci Tangan",
                            image: resolveIcon(for: "cucitangan"),
                            ruangan: Ruangan(id: UUID(), name: "KamarMandi"),
                            sequence: [
                                        Step(image: resolveIcon(for: "keran"), description: "Buka keran air"),
                                        Step(image: resolveIcon(for: ""), description: "Basahi tangan dengan air"),
                                        Step(image: resolveIcon(for: ""), description: "Ambil sabun"),
                                        Step(image: resolveIcon(for: ""), description: "Gosok sabun di tangan kiri"),
                                        Step(image: resolveIcon(for: ""), description: "Gosok sabun di tangan kanan"),
                                        Step(image: resolveIcon(for: ""), description: "Bilas sabun dengan air"),
                                        Step(image: resolveIcon(for: ""), description: "Keringkan tangan")
                            ]
                        ),
                        Activity(
                            id: UUID(),
                            name: "Cuci Piring",
                            image: resolveIcon(for: "piring"),
                            ruangan: Ruangan(id: UUID(), name: "RuangMakan"),
                            sequence: [
                                        Step(image: resolveIcon(for: ""), description: "Ambil piring dan sendok garpu kotor"),
                                        Step(image: resolveIcon(for: ""), description: "Basahilah dengan air"),
                                        Step(image: resolveIcon(for: ""), description: "Ambil spon dan beri sabun"),
                                        Step(image: resolveIcon(for: ""), description: "Gosok piring dan sendok garpu dengan sabun dan spon"),
                                        Step(image: resolveIcon(for: ""), description: "Bilas semua dengan air bersih"),
                                        Step(image: resolveIcon(for: ""), description: "Letakkan di tempat pengeringan")
                            ]
                        ),
                        Activity(
                            id: UUID(),
                            name: "Mewarnai",
                            image: resolveIcon(for: "WARNAI"),
                            ruangan: Ruangan(id: UUID(), name: "RuangBelajar"),
                            sequence: [
                                        Step(image: resolveIcon(for: ""), description: "Ambil buku dan pewarna"),
                                        Step(image: resolveIcon(for: ""), description: "Duduk di meja belajar"),
                                        Step(image: resolveIcon(for: ""), description: "Buka buku dan siapkan alat pewarna"),
                                        Step(image: resolveIcon(for: ""), description: "Mulai mewarnai tugas yang diberikan"),
                                        Step(image: resolveIcon(for: ""), description: "Setelah selesai, rapikan alat mewarnai"),
                                        Step(image: resolveIcon(for: ""), description: "Kembalikan peralatan pada tempatnya")
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
