//
//  AddDailyActivityView.swift
//  KataKita
//
//  Created by Alvito Dwi Reza on 10/10/24.
//

import SwiftUI

struct AddDailyActivityView: View {
    @State private var scheduleManager: ScheduleManager
    @State private var activitiesManager: ActivitiesManager
    @State private var searchText: String = ""
    
    @State private var selectedDayString: Int = 0
    // Viewport size
    private let viewPortWidth: CGFloat = UIScreen.main.bounds.width - 100
    private let viewPortHeight: CGFloat = UIScreen.main.bounds.height - 100

    init(_ scheduleManager: ScheduleManager, activities: [Activity]) {
        self.scheduleManager = scheduleManager
        self.activitiesManager = ActivitiesManager(activities)
    }
    /// Computed Property
    var selectedDay: Day {
        switch selectedDayString {
            case 0:
                return .MONDAY([])
            case 1:
                return .TUESDAY([])
            case 2:
                return .WEDNESDAY([])
            case 3:
                return .THURSDAY([])
            case 4:
                return .FRIDAY([])
            case 5:
                return .SATURDAY([])
            default:
                return .SUNDAY([])
        }
    }
    var day: Day {
        return self.scheduleManager.schedules.first(where: {
            $0.day == selectedDay
        })?.day ?? selectedDay
    }
    var extractActivity: [Activity] {
        if case let .MONDAY(activities) = self.day {
            return activities
        }
        if case let .TUESDAY(activities) = self.day {
            return activities
        }
        if case let .WEDNESDAY(activities) = self.day {
            return activities
        }
        if case let .THURSDAY(activities) = self.day {
            return activities
        }
        if case let .FRIDAY(activities) = self.day {
            return activities
        }
        if case let .SATURDAY(activities) = self.day {
            return activities
        }
        if case let .SUNDAY(activities) = self.day {
            return activities
        }
        return []
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 30) {
                Button {
                    // isi dengan function back
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                        .frame(width: 15, height: 15)
                    TextHeadline(
                        text: "Pengaturan",
                        size: 20,
                        color: "Black",
                        transparency: 1.0,
                        weight: "Light"
                    )
                }
                TextHeadline(
                    text: "Jadwal",
                    size: 36,
                    color: "Black",
                    transparency: 1.0,
                    weight: "Light"
                )
            }
            .padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50))
            .frame(height: 150, alignment: .topLeading)
            HStack {
                VStack(alignment: .leading) {
                    TextHeadline(
                        text: "Aktivitas yang dipilih",
                        size: 24,
                        color: "Black",
                        transparency: 1.0,
                        weight: "Light"
                    )
                    HStack(spacing: 20) {
                        TextHeadline (
                            text: "Hari",
                            size: 20,
                            color: "Black",
                            transparency: 1.0,
                            weight: "Light"
                        )
                        Spacer()
                        Picker("Hari", selection: $selectedDayString) {
                            Text("Senin").tag(0)
                            Text("Selasa").tag(1)
                            Text("Rabu").tag(2)
                            Text("Kamis").tag(3)
                            Text("Jumat").tag(4)
                            Text("Sabtu").tag(5)
                            Text("Minggu").tag(6)
                        }
                        .accentColor(Color(hex: "B4B4B5"))
                    }
                    .padding(15)
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            
                            .fill(Color(hex: "F7F5F0", transparency: 1.0))
                    )
                    ZStack {
                        if extractActivity.isEmpty {
                            Text("Jadwal masih kosong")
                        }
                        else {
                            ScrollView {
                                LazyVStack(spacing: 0) {
                                    ForEach(
                                        Array(extractActivity.enumerated()),
                                        id: \.offset
                                    ) { index, activity in
                                        SettingActivityCard(
                                            activity,
                                            number: index + 1,
                                            delete: {
                                                self.scheduleManager.removeActivity(
                                                    index: index, day: self.day)
                                            }
                                        )
                                    }
                                }.padding(.bottom, 140)
                            }
                        }
                        VStack(spacing: 0) {
                            Spacer()
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "BDD4CE", transparency: 0), Color(hex: "BDD4CE", transparency: 1.0)],
                                        startPoint: .top, endPoint: .bottom)
                                )
                                .frame(height: 70)
                            Rectangle()
                                .fill(Color(hex: "BDD4CE", transparency: 1.0))
                                .frame(height: 100)
                        }
                        VStack {
                            Spacer()
                            Button {
                                self.scheduleManager.removeAll(self.day)
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        Color(hex: "EB7D7B")
                                    )
                                    .frame(width: 150, height: 40)
                                    .overlay(
                                        Text("Hapus Semua").foregroundStyle(
                                            Color(hex: "FBFBFB"))
                                    )
                            }
                        }
                    }
                }
                .padding(30)
                .frame(
                    width: viewPortWidth * 0.5,
                    alignment: .topLeading
                )
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "BDD4CE", transparency: 1.0)))

                // View Kanan (Daftar aktivitas)
                VStack(alignment: .leading) {
                    TextHeadline (
                        text: "Daftar Aktivitas",
                        size: 24,
                        color: "Black",
                        transparency: 1.0,
                        weight: "Light"
                )
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }
                    .padding(.horizontal, 10)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "E0E0E1", transparency: 1.0))
                    )

                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(activitiesManager.activities) { activity in
                                SettingActivityCard(activity)
                                    .onTapGesture {
                                        /// Click handler
                                        self.scheduleManager.addActivity(
                                            activity, day: self.day)
                                    }
                            }
                        }
                    }
                }
                .padding(.leading, 30)
                .frame(
                    width: viewPortWidth * 0.5,
                    alignment: .topLeading
                )

                // View Kanan (List of Today's Activity)

            }
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 50, trailing: 50))
            .frame(height: viewPortHeight - 50)
        }
        .background(
            Rectangle()
                .fill(Color(hex: "FBFBFB", transparency: 1.0))
                .ignoresSafeArea()
        )

    }
}

#Preview {
    AddDailyActivityView(
        ScheduleManager(),
        activities: [
            Activity(
                id: UUID(),
                name: "Tidur",
                image: nil,
                sequence: []
            ),
            Activity(
                id: UUID(),
                name: "Mencuci Piring",
                image: nil,
                sequence: []
            ),
            Activity(
                id: UUID(),
                name: "Menyapu lantai",
                image: nil,
                sequence: []
            ),
            Activity(
                id: UUID(),
                name: "Mencuci Baju",
                image: nil,
                sequence: []
            ),
            Activity(
                id: UUID(),
                name: "Makan",
                image: nil,
                sequence: []
            ),
            Activity(
                id: UUID(),
                name: "Minum",
                image: nil,
                sequence: []
            ),
            Activity(
                id: UUID(),
                name: "Belajar",
                image: nil,
                sequence: []
            ),
            Activity(
                id: UUID(),
                name: "Gosok Gigi",
                image: nil,
                sequence: []
            ),
        ]
    )
}
