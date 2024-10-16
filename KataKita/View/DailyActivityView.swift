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
    @State private var dummyActivity: [(name: String, icon: String, isSystemImage: Bool, isClicked: Bool, isCompleted: Bool)] = [
        ("Gosok Gigi", "toothbrush", false, true, false),
        ("Mandi", "bathtub", true, false, false),
        ("Makan", "fork.knife", true, false, false),
        ("Belajar", "pencil.line", true, false, false)
    ]
    
    @State private var selectedActivity: String = "Gosok Gigi"
    @State private var isSetting: Bool = false
    @State private var buttonDoneGosokGigi: Bool = false
    @State private var buttonDoneBelajar: Bool = false
    @State private var buttonDoneMandi: Bool = false
    @State private var buttonDoneMakan: Bool = false


    
    @State private var currentIndex: Int = 0
    @State private var shouldNavigate: Bool = false
    @Environment(\.dismiss) var dismiss
    
    //ipad 13 inch preview
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let widthPreview = 1376.0
    let heightPreview = 1032.0
    
    var body: some View {
        NavigationStack {
            VStack() {
                HStack {
                    VStack(alignment: .leading) {
                        TextHeadline(
                            text: "Kegiatan Lucas",
                            size: Int(screenWidth * (50 / widthPreview)),
                            color: "000000",
                            weight: "bold")
                        
                        TextContent(
                            text: "Hari Senin",
                            size: Int(screenWidth * (40 / widthPreview)),
                            color: "00000",
                            weight: "extralight"
                        )
                        Spacer()
                    }
                    .padding(.leading, screenWidth * (50 / widthPreview))
                    Spacer()
                    VStack {
                        HStack(spacing:CGFloat(screenWidth * (25 / 1366.0))) {
                            CustomButton(
                                icon: "keyboard",
                                width: Int(screenWidth * (90 / 1366.0)),
                                height: Int(screenHeight * (90 / 1024.0)),
                                font: Int(screenWidth * (40 / widthPreview)),
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
                            
                        }
                        Spacer()
                    }
                }
                .padding(.top,80)
                .padding(.leading,50)
                .padding(.trailing,50)
                
                //
                VStack {
                    HStack {
                        //scroll button and scroll view
                        ScrollViewReader { proxy in
                            HStack(spacing:0) {
                                //scroll button
                                VStack {
                                    Spacer()
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
                                    
                                }
                                
                                //scroll view
                                VStack {
                                    ZStack {
                                        //cream bg
                                        UnevenRoundedRectangle()
                                            .foregroundColor(Color(hex: "F7F5F0", transparency: 1.0))
                                            .edgesIgnoringSafeArea(.bottom)
                                            .frame(width:CGFloat(screenWidth * (220 / 1210.0)), height: CGFloat(screenHeight) * (1000 / 1210) )
                                            .clipShape(Capsule())
                                            .ignoresSafeArea(.all)
                                            .padding(.top, CGFloat(screenHeight * (40 / 834.0)))
                                        
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
                                                            // Ensure that previous activity is completed before selecting this one
                                                                                                           if index > 0 && !dummyActivity[index - 1].isCompleted {
                                                                                                               speakText(dummyActivity[index].name)
                                                                                                               return
                                                                                                           }
                                                                                                           
                                                                                                           // Proceed with selecting and marking the current activity
                                                                                                           for i in 0..<dummyActivity.count {
                                                                                                               dummyActivity[i].isClicked = false
                                                                                                           }
                                                                                                           dummyActivity[index].isClicked = true
                                                                                                           selectedActivity = dummyActivity[index].name
                                                                                                           speakText(dummyActivity[index].name)
                                                        }
                                                    )
                                                    .id(index)
                                                }
                                                .padding(.top, CGFloat(screenHeight * (15 / 834.0)))
                                                
                                            }
                                        }
                                        .clipShape(Capsule())
                                        .frame(height: CGFloat(screenHeight) * (900 / 1210) )
                                            .padding(.top,CGFloat(screenHeight * (40 / 1024.0)) )

                                        
                                        
                                    }.frame(height: CGFloat(screenHeight) * (900 / 1210))
                                        
                                    
                                        
                                }
                                .ignoresSafeArea(.all)
                            }
                        }
                        //activity sequence
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .frame(
                                    width: CGFloat(screenWidth) * (850 / 1210),
                                    height: CGFloat(screenHeight) * (900 / 1210))
                                .foregroundColor(Color(hex: "BDD4CE", transparency: 1.0))
                            
                            
                            
                            VStack (spacing:0) {
                                HStack {
                                    TextHeadline(text: "Tahapan Aktivitas", size: 30, color: "000000", weight: "bold")
                                    Spacer()
                                }
                                .padding(.leading, screenWidth * (30/widthPreview))
                                .padding(.top, screenWidth * (30/widthPreview))
                                
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
                                
                                HStack {
                                    // Button SELESAI
                                    ForEach(dummyActivity.indices, id: \.self) { index in
                                        let activity = dummyActivity[index]
                                        
                                        if selectedActivity == activity.name {
                                            CustomButtonSide(
                                                icon: "hand.thumbsup.fill",
                                                text: "SELESAI",
                                                width: Int(screenWidth * (150 / 1210.0)),
                                                height: Int(screenHeight * (50 / 834.0)),
                                                font: Int(screenWidth * (15 / 1210.0)),
                                                iconWidth: Int(screenWidth * (15 / 1210.0)),
                                                iconHeight: Int(screenHeight * (15 / 834.0)),
                                                bgColor: "F7F5F0",
                                                bgTransparency: activity.isCompleted ? 1.0 : 0.0,
                                                fontColor: "000000",
                                                fontTransparency: 1.0,
                                                cornerRadius: 20,
                                                strokeColor: "000000",
                                                action: {
                                                    completeCurrentActivity()
                                                    if activity.isClicked {
                                                        dummyActivity[index].isCompleted = true
                                                    }
                                                }
                                            )
                                        }
                                    }

                                    
 
                                }
                                .frame(height: screenHeight * (50/heightPreview))
                                
                                Spacer()
                            }
                            
                        }
                        .frame(
                            width: CGFloat(screenWidth) * (850 / 1210),
                            height: CGFloat(screenHeight) * (900 / 1210))
                        .padding(.bottom)
                        
                        
                    }
                }
                
            }
            .background(Color(hex: "FBFBFB", transparency: 1.0))
            .ignoresSafeArea(.all)
            .edgesIgnoringSafeArea(.all)
           
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
        .navigationBarBackButtonHidden(true)
        
        
    }
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    // Speak function
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }
    
    func completeCurrentActivity() {
        if currentIndex < dummyActivity.count {
            dummyActivity[currentIndex].isCompleted = true
            
            if selectedActivity == "Gosok Gigi" {
                buttonDoneGosokGigi = true
            } else if selectedActivity == "Mandi" {
                buttonDoneMandi = true
            } else if selectedActivity == "Belajar" {
                buttonDoneBelajar = true
            } else if selectedActivity == "Makan" {
                buttonDoneBelajar = true
            }

            if currentIndex + 1 < dummyActivity.count {
                dummyActivity[currentIndex].isClicked = false
                dummyActivity[currentIndex + 1].isClicked = true
                selectedActivity = dummyActivity[currentIndex + 1].name
                currentIndex += 1
            }
        }
    }
}

#Preview {
    DailyActivityView()
}
