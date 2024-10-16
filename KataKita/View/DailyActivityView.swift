//
//  DailyActivityView.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 10/10/24.
//
import SwiftUI
import AVFoundation


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
    @State private var isSetting: Bool = false

    @State private var currentIndex: Int = 0
    @State private var shouldNavigate: Bool = false
    @Environment(\.dismiss) var dismiss
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                VStack {
                    
                    HStack {
                        Spacer()
                        ZStack {
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
                                                ZStack {
                                                    UnevenRoundedRectangle()
                                                        .foregroundColor(Color(hex: "F7F5F0", transparency: 1.0))
                                                        .edgesIgnoringSafeArea(.bottom)
                                                        .frame(width:CGFloat(screenWidth * (180 / 1210.0)), height: CGFloat(screenHeight) * (900 / 1210) )
                                                        .offset(x:CGFloat(screenWidth * (2 / 1366.0)))
                                                        .clipShape(Capsule())
                                                    
                                                    
                                                    ScrollView {
                                                        ForEach(0..<dummyActivity.count, id: \.self) { index in
                                                            ZStack {
                                                                // Selected rounded rectangle with conditional opacity
                                                                Circle()
                                                                    .fill(Color(hex: "BDD4CE", transparency: 1.0))
                                                                    .opacity(dummyActivity[index].isClicked ? 1.0 : 0.0)
                                                                    .frame(
                                                                        width: CGFloat(screenWidth * (250 / 1210.0)),
                                                                        height: CGFloat(screenHeight * (130 / 834.0))
                                                                    )
                                                                    .shadow(radius: 0.1)
                                                                
                                                                
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
                                                                    bgTransparency: 0,
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
                                                                        
                                                                        speakText(dummyActivity[index].name)
                                                                        
                                                                    }
                                                                ) .id(index)
                                                            }
                                                            .padding(.bottom, CGFloat(screenHeight * (15 / 834.0)))
                                                        }
                                                    }.padding()
                                                        .clipShape(Capsule())
                                                    
                                                }.frame(height: CGFloat(screenHeight) * (900 / 1210))
                                                    .padding(.top,CGFloat(screenHeight * (50 / 1024.0)) )
                                            }
                                        }
                                        .padding(.leading, CGFloat(screenWidth) * (20 / 1366.0))
                                    }
                                    ZStack {
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                            .frame(
                                                width: CGFloat(screenWidth) * (900 / 1210),
                                                height: CGFloat(screenHeight) * (1100 / 1210))
                                            .foregroundColor(Color(hex: "BDD4CE", transparency: 1.0))
                                        
                                        VStack {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 0) {
                                                    TextHeadline(
                                                        text: "JADWAL LUCAS",
                                                        size: Int(screenWidth * (48 / 1210.0)),
                                                        color: "00000",
                                                        weight: "bold"
                                                    )
                                                    HStack {
                                                        TextHeadline(
                                                            text: "HARI INI",
                                                            size: Int(screenWidth * (24 / 1210.0)),
                                                            color: "00000", weight: "regular"
                                                        )
                                                        TextHeadline(
                                                            text: "SENIN",
                                                            size: Int(screenWidth * (24 / 1210.0)),
                                                            color: "00000", weight: "bold"
                                                        )
                                                    }
                                                }
                                                .padding(.leading, CGFloat(screenWidth * (40 / 1366.0)))
                                                .padding(.top, CGFloat(screenHeight * (14 / 1024.0)))
                                                
                                                Spacer()
                                                
                                                HStack(spacing:CGFloat(screenWidth * (25 / 1366.0))) {
                                                    CustomButton(
                                                        icon: "keyboard",
                                                        width: Int(screenWidth * (90 / 1366.0)),
                                                        height: Int(screenHeight * (90 / 1024.0)),
                                                        font: 40,
                                                        iconWidth: Int(screenWidth * (40 / 1366.0)),
                                                        iconHeight: Int(screenWidth * (40 / 1366.0)),
                                                        bgColor: "eeeeee",
                                                        bgTransparency: 1.0,
                                                        fontColor: "696767",
                                                        fontTransparency: 1.0,
                                                        cornerRadius: 20,
                                                        action: {
                                                            
                                                            shouldNavigate = true
                                                        }
                                                        
                                                    )
                                                    NavigationLink(destination: SettingsView()) {
                                                        CustomButton(
                                                            icon: "settings",
                                                            width: Int(screenWidth * (90 / 1366.0)),
                                                            height: Int(screenHeight * (90 / 1024.0)),
                                                            font: 40,
                                                            iconWidth: Int(screenWidth * (40 / 1366.0)),
                                                            iconHeight: Int(screenWidth * (40 / 1366.0)),
                                                            bgColor: "eeeeee",
                                                            bgTransparency: 1.0,
                                                            fontColor: "696767",
                                                            fontTransparency: 1.0,
                                                            cornerRadius: 20,
                                                            isSystemImage: false,
                                                            action: {
                                                                isSetting = true
                                                            }
                                                        )
                                                    }
                                                    CustomButton(
                                                        icon: "house.fill",
                                                        width: Int(screenWidth * (90 / 1366.0)),
                                                        height: Int(screenHeight * (90 / 1024.0)),
                                                        font: 40,
                                                        iconWidth: Int(screenWidth * (40 / 1366.0)),
                                                        iconHeight: Int(screenWidth * (40 / 1366.0)),
                                                        bgColor: "eeeeee",
                                                        bgTransparency: 1.0,
                                                        fontColor: "696767",
                                                        fontTransparency: 1.0,
                                                        cornerRadius: 20,
                                                        action: {
                                                            dismiss()
                                                            
                                                        }
                                                    )
                                                }.padding(.trailing, CGFloat(screenWidth * (50 / 1366.0)))
                                                    .padding(.top, CGFloat(screenHeight * (14 / 1024.0)))
                                            }
                                            
                                            
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
                                            .padding()
                                    }
                                    .padding(.trailing, CGFloat(screenWidth) * (20 / 1366.0))
                                }
                                Spacer()
                            }.padding()
                        }
                        Spacer()
                    }
                }
            }
            .background(Color(hex: "FBFBFB", transparency: 1.0))
            .onAppear{
                print(selectedActivity)
            }
//            NavigationLink(
//                destination: selectedActivity == "Makan" ? AnyView(AACRuangMakanView()) : AnyView(EmptyView()),
//                isActive: $shouldNavigate,
//                label: {
//                    EmptyView()
//                }
//            )
            NavigationLink(
                destination: {
                    switch selectedActivity {
                    case "Makan":
                        AnyView(AACRuangMakanView())
//                    case "Setting":
//                        AnyView(SettingsView().onAppear{
//                            selectedActivity = "Gosok Gigi"
//                        })
//                            
                    default:
                        AnyView(EmptyView())
                    }
                }(),
                isActive: $shouldNavigate,
                label: {
                    EmptyView()
                }
            )
            NavigationLink(destination: SettingsView(), isActive: $isSetting) {
                    EmptyView()  // Label is hidden, but link is active
                }
        }
    }
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    // Speak function
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }
}

#Preview {
    DailyActivityView()
}
