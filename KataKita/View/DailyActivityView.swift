//
//  DailyActivityView.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 10/10/24& Edited by Alvito Dwi Heldy Muhammad on 17/10/2024.
//
import SwiftUI
import AVFoundation

/// 
struct DailyActivityView: View {
    @Environment(ScheduleManager.self) private var scheduleManager
    @Environment(\.dismiss) var dismiss
    @Environment(StateManager.self) private var stateManager
    
//    @State private var selectedActivity: String = "Gosok Gigi"
//    @State private var isSetting: Bool = false
//
//    @State private var currentIndex: Int = 0
//    @State private var shouldNavigate: Bool = false

    //MARK: viewport size
    let viewPortWidth = UIScreen.main.bounds.width
    let viewPortHeight = UIScreen.main.bounds.height
    
    /// Computed property
    var selectedDay: Day {
        let day = Date().dayNumberOfWeek()
        switch day {
            case 0:
                return .SUNDAY([])
            case 1:
                return .MONDAY([])
            case 2:
                return .TUESDAY([])
            case 3:
                return .WEDNESDAY([])
            case 4:
                return .THURSDAY([])
            case 5:
                return .FRIDAY([])
            default:
                return .SATURDAY([])
        }
    }
    
    var day: Day {
        return self.scheduleManager.schedules.first(where: { $0.day == self.selectedDay })?.day ?? self.selectedDay
    }
    var dayToString: String {
        let day = Date().dayNumberOfWeek()
        switch day {
            case 0:
                return "Minggu"
            case 1:
                return "Senin"
            case 2:
                return "Selasa"
            case 3:
                return "Rabu"
            case 4:
                return "Kamis"
            case 5:
                return "Jumat"
            default:
                return "Sabtu"
        }
    }
    
    var extractActivity: [Activity] {
        return self.day.extractActivities()
    }
    var steps: [Step] {
        return self.extractActivity[safe: self.stateManager.index]?.sequence ?? []
    }
    
    var isCompleted: Bool {
        return self.extractActivity.count <= self.stateManager.index
    }
    
    var body: some View {
        VStack (spacing: 0) {
            //MARK: - Header
            HStack (alignment: .top , spacing: 15) {
                VStack (alignment: .leading) {
                    TextHeadline(
                        text: "Kegiatan Lucas",
                        size: 36,
                        color: "Black",
                        transparency: 1.0,
                        weight: "Light"
                    )
                    TextContent(
                        text: "Hari \(self.dayToString),",
                        size: 24,
                        color: "Black",
                        transparency: 1.0,
                        weight: "Light"
                    )
                }
                Spacer()
                CustomButton(
                    icon: "keyboard",
                    width: 70,
                    height: 70,
                    font: 50,
                    iconWidth: 30,
                    iconHeight: 30,
                    bgColor: "013C5A",
                    bgTransparency: 1.0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 20
                )
                CustomButton(
                    icon: "house.fill",
                    width: 70,
                    height: 70,
                    font: 50,
                    iconWidth: 30,
                    iconHeight: 30,
                    bgColor: "013C5A",
                    bgTransparency: 1.0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 20,
                    action: {
                        dismiss()
                    }
                )
                CustomButton(
                    icon: "gearshape.fill",
                    width: 70,
                    height: 70,
                    font: 50,
                    iconWidth: 30,
                    iconHeight: 30,
                    bgColor: "013C5A",
                    bgTransparency: 1.0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 20
                )
            }
            .padding(.horizontal, 50)
            .frame(width: viewPortWidth, height: viewPortHeight * 0.15)
            
            
            //MARK: - Body
            HStack (alignment: .top , spacing: 50) {
                //MARK: viewport kiri (List kegiatan hari ini)
                LazyVStack (alignment: .center, spacing: 0) {
                    ForEach(Array(self.extractActivity.enumerated()), id: \.offset) { index, activity in
                        if self.stateManager.index <= index {
                            ActivityCard(
                                icon: "ball",
                                nomor: "",
                                text: "\(activity.name)",
                                width: Int((viewPortWidth * 0.75 - 290) / 4),
                                height: Int(viewPortWidth * (180 / 1210.0)),
                                font: Int(viewPortWidth * (15 / 1210.0)),
                                iconWidth: Int(viewPortWidth * (50 / 1210.0)),
                                iconHeight: Int(viewPortHeight * (50 / 834.0)),
                                bgColor: "BDD4CE",
                                bgTransparency: index == self.stateManager.index ? 1.0 : 0,
                                fontColor: "000000",
                                fontTransparency: 1.0,
                                cornerRadius: 20,
                                isSystemImage: false
                            )
                        } else {
                            EmptyView()
                        }
                        
                    }
                }
                .padding(.vertical, 30)
                .frame(width: viewPortWidth * 0.25 - 50)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "F7F5F0", transparency: 1.0))
                )
                
                                
                
                // MARK: Viewport bagian kanan (Tahapan aktivitas)
                VStack (alignment: .leading, spacing: 20) {
                    TextHeadline(
                        text: "Tahapan aktivitas",
                        size: 24,
                        color: "Black",
                        transparency: 1.0,
                        weight: "Light"
                    )
                    if self.isCompleted {
                        Spacer()
                        TextContent(
                            text: "Kamu telah menyelesaikan aktivitasmu!",
                            size: 24,
                            color: "Black",
                            transparency: 1.0,
                            weight: "Light"
                        )
                        .frame(maxWidth: .infinity)
                        Spacer()
                    } else {
                        ScrollView{
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                ],
                                spacing: 30
                            ) {
                                
                                ForEach(Array(self.steps.enumerated()), id: \.offset) { i, step in
                                    ActivityCard(
                                        icon: "ball",
                                        nomor: "\(i + 1)",
                                        text: step.description,
                                        width: Int((viewPortWidth * 0.75 - 290) / 4), height: Int(viewPortWidth * (180 / 1210.0)),
                                        font: Int(viewPortWidth * (15 / 1210.0)), iconWidth: Int(viewPortWidth * (50 / 1210.0)), iconHeight: Int(viewPortHeight * (50 / 834.0)),
                                        bgColor: "F7F5F0", bgTransparency: 1.0,
                                        fontColor: "000000", fontTransparency: 1.0,
                                        cornerRadius: 20, isSystemImage: false
                                    )
                                }
                            }
                            .padding(.bottom, 160)
                        }
                    
              
                }
                .padding(50)
                .frame(width: viewPortWidth * 0.75 - 100, height: viewPortHeight * 0.85 - 50, alignment: .topLeading)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "BDD4CE", transparency: 1.0))
                        
                )
                .overlay(
                    VStack (spacing: 0) {
                        Spacer()
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "BDD4CE", transparency: 0), Color(hex: "BDD4CE", transparency: 1.0)],
                                    startPoint: .top, endPoint: .bottom)
                            )
                            .frame(height: 60)
                        
                        if self.isCompleted {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "BDD4CE", transparency: 1.0))
                                .frame(height: 100)
                        } else {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "BDD4CE", transparency: 1.0))
                                .frame(height: 100)
                                .overlay(
                                    CustomButton(
                                        text: "Selesai",
                                        width: 150,
                                        height: 50,
                                        font: 14,
                                        bgColor: "#013C5A",
                                        bgTransparency: 1.0,
                                        fontColor: "#F7F5F0",
                                        fontTransparency: 1.0,
                                        cornerRadius: 20,
                                        action: {
                                            self.stateManager.increment()
                                        }
                                    )
                                )
                        }
                    }
                    
                )
            }
            .padding(.horizontal, 50)
            .frame(width: viewPortWidth, height: viewPortHeight * 0.85, alignment: .topLeading)
        }
        .frame(width: viewPortWidth, height: viewPortHeight)
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            // statemanager
        }
    }
}

//#Preview {
//    DailyActivityView()
//}
