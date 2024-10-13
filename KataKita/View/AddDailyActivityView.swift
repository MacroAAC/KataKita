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
    @State private var selectedDay: Day = .MONDAY([])
    
    // Viewport size
    private let viewPortWidth: CGFloat = UIScreen.main.bounds.width - 120
    private let viewPortHeight: CGFloat = UIScreen.main.bounds.height - 120
    
    init(_ scheduleManager: ScheduleManager,activities: [Activity]) {
        self.scheduleManager = scheduleManager
        self.activitiesManager = ActivitiesManager(activities)
    }
    /// Computed Property
    var day: Day {
        return self.scheduleManager.schedules.first(where: { $0.day == selectedDay })?.day ?? selectedDay
    }
    var extractActivity: [Activity] {
        if case let .MONDAY(activities) = self.day {
            return activities
        }
        return []
    }
    var body: some View {
        HStack {
            // View Kiri (List of Activity)
            VStack (alignment: .leading) {
                Text("Aktivitas Harian")
                    .font(.custom("SFProRounded", size: 40))
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText)
                }
                .padding(.horizontal, 10)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.tertiary)
                )
                
                ScrollView {
                    LazyVStack (spacing: 0) {
                        ForEach(activitiesManager.activities) { activity in
                            SettingActivityCard(activity)
                                .onTapGesture { /// Click handler
                                    scheduleManager.addActivity(activity, day: self.day)
                                }
                        }
                    }
                }
            }
            .padding(.trailing, 60)
            .frame(width: viewPortWidth * 0.6, height: viewPortHeight * 1, alignment: .topLeading)
            
            // View Kanan (List of Today's Activity)
            VStack (alignment: .leading) {
                Text("Aktivitas yang dipilih")
                    .font(.title)
                ZStack {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(Array(extractActivity.enumerated()), id: \.offset) { index, activity in
                                SettingActivityCard(
                                    activity,
                                    number: index + 1,
                                    delete: {
                                        self.scheduleManager.removeActivity(index: index, day: self.day)
                                    }
                                )
                            }
                        }.padding(.bottom, 140)
                    }
                    VStack (spacing: 0){
                        Spacer()
                        Rectangle()
                            .fill(LinearGradient(colors: [.clear, .white], startPoint: .top, endPoint: .bottom))
                            .frame(height: 70)
                        Rectangle()
                            .fill(.white)
                            .frame(height: 100)
                    }
                    VStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 10).fill(.yellow).frame(width: 150, height: 40)
                                .overlay(
                                    Text("Simpan").foregroundStyle(.black)
                                )
                        }
                    }
                }
            }
            .padding(30)
            .frame(width: viewPortWidth * 0.4, height: viewPortHeight, alignment: .topLeading)
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(.white))
        }
        .padding(60)
        .background(
                Rectangle()
                    .fill(.tertiary)
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
            )
        ]
    )
}
