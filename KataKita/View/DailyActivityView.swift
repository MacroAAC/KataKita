//
//  DailyActivityView.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 10/10/24.
//
import SwiftUI

struct DailyActivityView: View {
    // Dummy data for activities
    @State private var dummyActivity: [(name: String, icon: String, isSystemImage: Bool, isClicked: Bool)] = [
        ("Gosok Gigi", "toothbrush", false, true),
        ("Mandi", "bathtub", true, false),
        ("Makan", "fork.knife", true, false),
        ("Belajar", "pencil.line", true, false),
        ("Belajar", "pencil.line", true, false)
    ]
    
    @State private var selectedActivity: String = "Gosok Gigi"
    @State private var currentIndex: Int = 0
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        TextHeadline(
                            text: "JADWAL LUCAS",
                            size: Int(screenWidth * (48 / 1210.0)),
                            color: "00000",
                            weight: "bold"
                        )
                        TextHeadline(
                            text: "HARI INI SENIN",
                            size: Int(screenWidth * (24 / 1210.0)),
                            color: "00000", weight: "bold"
                        )
                        .fontWeight(.bold)
                    }
                    .padding(.leading, CGFloat(screenWidth * (54 / 1366.0)))
                    .padding(.top, CGFloat(screenHeight * (14 / 1024.0)))
                    Spacer()
                    HStack(spacing:CGFloat(screenWidth * (40 / 1366.0))) {
                        CustomButton(
                            icon: "house.fill",
                            width: Int(screenWidth * (100 / 1366.0)),
                            height: Int(screenHeight * (100 / 1024.0)),
                            font: 50,
                            iconWidth: Int(screenWidth * (50 / 1366.0)),
                            iconHeight: Int(screenWidth * (50 / 1366.0)),
                            bgColor: "eeeeee",
                            bgTransparency: 1.0,
                            fontColor: "696767",
                            fontTransparency: 1.0,
                            cornerRadius: 20
                        )
                        CustomButton(
                            icon: "house.fill",
                            width: Int(screenWidth * (100 / 1366.0)),
                            height: Int(screenHeight * (100 / 1024.0)),
                            font: 50,
                            iconWidth: Int(screenWidth * (50 / 1366.0)),
                            iconHeight: Int(screenWidth * (50 / 1366.0)),
                            bgColor: "eeeeee",
                            bgTransparency: 1.0,
                            fontColor: "696767",
                            fontTransparency: 1.0,
                            cornerRadius: 20
                        )
                    }.padding(.trailing, CGFloat(screenWidth * (50 / 1366.0)))
                        .padding(.top, CGFloat(screenHeight * (14 / 1024.0)))
                }
                .fontWeight(.bold)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(hex: "#ffffff", transparency: 1.0))
                        .padding()
                    HStack {
                        Spacer()
                        HStack(spacing:CGFloat(screenHeight * (-30 / 834.0))) {
                            ScrollViewReader { proxy in
                                // Left sidebar
                                ZStack {
                                    HStack(spacing: CGFloat(screenWidth * (-10 / 1366.0))) {
                                        // Button for scroll
                                        VStack {
                                            CustomButton(
                                                icon: "arrowtriangle.up",
                                                width: Int(screenWidth * (40 / 1210.0)),
                                                height: Int(screenHeight * (40 / 834.0)),
                                                font: Int(screenWidth * (24 / 1366.0)),
                                                iconWidth: Int(screenWidth * (20 / 1210.0)),
                                                iconHeight: Int(screenHeight * (20 / 834.0)),
                                                bgColor: "000000",
                                                bgTransparency: 0,
                                                fontColor: "#000000",
                                                fontTransparency: 1.0,
                                                cornerRadius: 20,
                                                isSystemImage: true,
                                                         
                                                action: {
                                                    withAnimation {
                                                    let newIndex = max(currentIndex - 2, 0)
                                                    proxy.scrollTo(newIndex, anchor: .center)
                                                    currentIndex = newIndex
                                                    print(currentIndex)
                                                }
                                            }
                                            )
                                            
                                            CustomButton(
                                                icon: "arrowtriangle.down",
                                                width: Int(screenWidth * (40 / 1210.0)),
                                                height: Int(screenHeight * (40 / 834.0)),
                                                font: Int(screenWidth * (24 / 1366.0)),
                                                iconWidth: Int(screenWidth * (20 / 1210.0)),
                                                iconHeight: Int(screenHeight * (20 / 834.0)),
                                                bgColor: "000000",
                                                bgTransparency: 0,
                                                fontColor: "#000000",
                                                fontTransparency: 1.0,
                                                cornerRadius: 20,
                                                isSystemImage: true,
                                                         action: {
                                                withAnimation {
                                                    let newIndex = min(currentIndex + 2, dummyActivity.count - 1)
                                                    proxy.scrollTo(newIndex, anchor: .center)
                                                    currentIndex = newIndex
                                                    print(currentIndex)
                                                }
                                            }
                                                         
                                            )
                                            
                                        }.zIndex(1)
                                        ScrollView {
                                            ForEach(0..<dummyActivity.count, id: \.self) { index in
                                                ZStack {
                                                    // Selected rounded rectangle with conditional opacity
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .fill(Color(hex: "F7F7F8", transparency: 1.0))
                                                        .opacity(dummyActivity[index].isClicked ? 1.0 : 0.0)
                                                        .frame(
                                                            width: CGFloat(screenWidth * (250 / 1210.0)),
                                                            height: CGFloat(screenHeight * (130 / 834.0))
                                                        )
                                                        .offset(x:CGFloat(screenWidth * (50 / 1366.0)))
                                                    
                                                    // Activity button
                                                    CustomButton(
                                                        icon: dummyActivity[index].1,
                                                        text: dummyActivity[index].0,
                                                        width: Int(screenWidth * (120 / 1210.0)),
                                                        height: Int(screenHeight * (120 / 834.0)),
                                                        font: Int(screenWidth * (24 / 1366.0)),
                                                        iconWidth: Int(screenWidth * (40 / 1210.0)),
                                                        iconHeight: Int(screenHeight * (40 / 834.0)),
                                                        bgColor: "FFFFFF",
                                                        bgTransparency: 1.0,
                                                        fontColor: "#000000",
                                                        fontTransparency: 1.0,
                                                        cornerRadius: 20,
                                                        isSystemImage: dummyActivity[index].2,
                                                        action: {
                                                            for i in 0..<dummyActivity.count {
                                                                dummyActivity[i].isClicked = false
                                                            }
                                                            dummyActivity[index].isClicked = true
                                                            selectedActivity = dummyActivity[index].0
                                                            print("Selected activity: \(dummyActivity[index].name)")
                                                            print("index \(index)")
                                                        }
                                                    ) .id(index)
                                                }
                                                .padding(.bottom, CGFloat(screenHeight * (15 / 834.0)))
                                            }
                                        }
                                    }.frame(height: CGFloat(screenHeight) * (900 / 1210))
                                        .padding(.top,CGFloat(screenHeight * (1 / 1024.0)) )
                                }
                                .padding(.leading, CGFloat(screenWidth) * (20 / 1366.0))
                            }
                            ZStack {
                                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                    .frame(
                                        width: CGFloat(screenWidth) * (900 / 1210),
                                        height: CGFloat(screenHeight) * (900 / 1210))
                                    .foregroundColor(Color(hex: "F7F7F8", transparency: 1.0))
                                
                                VStack {
                                    // Activity sequence view displayed based on the selected activity
                                    if selectedActivity == "Gosok Gigi" {
                                        ActivitySequenceView(
                                            steps: [
                                                "Ambil sikat gigi",
                                                "Ambil pasta gigi",
                                                "Tuangkan pasta gigi",
                                                "Mulai menyikat gigi",
                                                "Kumur air"
                                            ], selectedActivity: $selectedActivity)
                                    } else if selectedActivity == "Mandi" {
                                        ActivitySequenceView(
                                            steps: [
                                                "Siapkan handuk",
                                                "Siapkan pakaian",
                                                "Buka baju dan letakan pada keranjang baju kotor",
                                                "Nyalakan shower air",
                                                "Usapkan sabun mandi pada badan",
                                                "Siram kembali badan dengan air",
                                                "Keringkan badan menggunakan handuk",
                                                "Nyalakan shower air",
                                                "Usapkan sabun mandi pada badan",
                                                "Siram kembali badan dengan air",
                                                "Keringkan badan menggunakan handuk"
                                            ], selectedActivity: $selectedActivity)
                                    } else if selectedActivity == "Makan" {
                                        ActivitySequenceView(
                                            steps: [
                                                "Sikat gigi",
                                                "Ambil pasta gigi",
                                                "Tuangkan pasta gigi",
                                                "Mulai menyikat gigi",
                                                "Kumur air",
                                                "Selesai"
                                            ], selectedActivity: $selectedActivity)
                                        
                                    } else if selectedActivity == "Belajar" {
                                        ActivitySequenceView(
                                            steps: [
                                                "Ambil pensil",
                                                "Buka buku",
                                                "Mulai menulis",
                                                "Belajar selesai"
                                        ], selectedActivity: $selectedActivity)
                                    }
                                    Spacer()
                                }.padding(.top,CGFloat(screenHeight * (10 / 1024.0)))
                            }
                            .padding(.trailing, CGFloat(screenWidth) * (20 / 1366.0))
                        }
                        Spacer()
                    }.padding()
                }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    CustomButtonSide(
                        icon:"keyboard",
                        text: "PAPAN AAC",
                        width: 220,
                        height: 80,font: 20,
                        iconWidth: 25,
                        iconHeight: 25,
                        bgColor: "fffffff",
                        bgTransparency: 1.0,
                        fontColor: "000000",
                        fontTransparency: 1.0,
                        cornerRadius: 14
                    )
                }
            }.padding(.bottom,CGFloat(screenHeight * (-25 / 1024.0)))
        }
        .background(Color(hex: "F7F7F8", transparency: 1.0))
    }
}

#Preview {
    DailyActivityView()
}
