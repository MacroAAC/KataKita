//
//  RuangMakanView.swift
//  KataKita
//
//  Created by Lisandra Nicoline on 14/10/24.
//

import SwiftUI
import AVFoundation

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

struct AACRuangMakanView: View {
    // Update selectedButton to include the icon
    @State private var selectedButton: [(String, String, String)] = []
    
    // Update columnsData to include an additional String for font color
    @State private var columnsData: [[(String, String, String)]] = [
        [("saya", "#FFEBAF", "#000000"), ("kamu", "#FFEBAF", "#000000"), ("dia", "#FFEBAF", "#000000"), ("kita", "#FFEBAF", "#000000"), ("mama", "#FFEBAF", "#000000"), ("papa", "#FFEBAF", "#000000")],
        [("apa", "#A77DFF", "#000000"), ("dimana", "#A77DFF", "#000000"), ("siapa", "#A77DFF", "#000000")],
        [("suka", "#FFB0C7", "#000000"), ("tidak suka", "#FFB0C7", "#000000"), ("mau", "#FFB0C7", "#000000"), ("tidak mau", "#FFB0C7", "#000000"), ("tolong", "#FFB0C7", "#000000")],
        [("makan", "#CFF0C8", "#000000"), ("minum", "#CFF0C8", "#000000"), ("putar", "#CFF0C8", "#000000"), ("buka", "#CFF0C8", "#000000"), ("tutup", "#CFF0C8", "#000000")],
        [("masukkan", "#CFF0C8", "#000000"), ("ambil", "#CFF0C8", "#000000"), ("kunyah", "#CFF0C8", "#000000"), ("potong", "#CFF0C8", "#000000"), ("buang", "#CFF0C8", "#000000")],
        [("dingin", "#D4F3FF", "#000000"), ("panas", "#D4F3FF", "#000000"), ("asin", "#D4F3FF", "#000000"), ("manis", "#D4F3FF", "#000000")],
        [("sendok", "#F2B95C", "#000000"), ("garpu", "#F2B95C", "#000000"), ("piring", "#F2B95C", "#000000"), ("mangkok", "#F2B95C", "#000000"), ("gelas", "#F2B95C", "#000000")],
        [("di", "#FFFFFF", "#000000"), ("ke", "#FFFFFF", "#000000"), ("dan", "#FFFFFF", "#000000")],
        [("hitam", "#000000", "#000000"), ("cokelat", "#835737", "#835737"), ("oranye", "#E9AE50", "#E9AE50"), ("merah", "#E54646", "#E54646"), ("ungu", "#B378D8", "#B378D8"), ("pink", "#EDB0DC", "#EDB0DC"), ("biru", "#889AE4", "#889AE4"), ("hijau", "#B7D273", "#B7D273"), ("kuning", "#EFDB76", "#EFDB76")]
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let speechSynthesizer = AVSpeechSynthesizer()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(spacing:-13) {
            HStack {
                Button(action: {
                    speakAllText(from: selectedButton)
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width:screenWidth * (1190 / 1376),height:screenHeight * (180 / 1032))
                            .cornerRadius(10)
                            .padding(.leading, screenWidth * (28 / 1376))
                        
                        // HStack for displaying the selected buttons
                        HStack {
                            ForEach(selectedButton.indices, id: \.self) { index in
                                if index < 11 {
                                    // Display CustomButton for the first 11 items
                                    CustomButton(
                                        icon: "person.fill", // Use the new icon variable
                                        text: selectedButton[index].0, // Accessing the text from the tuple
                                        width: Int(screenWidth * (100 / 1376)),
                                        height: Int(screenHeight * (100 / 1032)),
                                        font: Int(screenWidth * (16 / 1376)),
                                        iconWidth: Int(screenWidth * (50 / 1376)),
                                        iconHeight: Int(screenHeight * (50 / 1032)),
                                        bgColor: selectedButton[index].1, // Accessing the background color from the tuple
                                        bgTransparency: 1.0,
                                        fontColor: selectedButton[index].2, // Accessing the font color from the tuple
                                        fontTransparency: 1.0,
                                        cornerRadius: 10,
                                        isSystemImage: true,
                                        action: {}
                                    )
                                } else {
                                    // Display plain Text for items beyond the 11th
                                    Text(selectedButton[index].0)
                                        .font(.system(size: screenWidth * (16 / 1376)))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, screenWidth * (5 / 1376))
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, screenWidth * (33 / 1376))
                        .padding()
                     
                        HStack {
                            CustomButton(
                                icon: "delete",
                                width: Int(screenWidth * (100/1376.0)),
                                height: Int(screenHeight * (100/1032.0)),
                                font: Int(screenWidth * (40/1376.0)),
                                iconWidth: Int(screenWidth * (50/1376.0)),
                                iconHeight: Int(screenHeight * (50/1032.0)),
                                bgColor: "#000000",
                                bgTransparency: 0,
                                fontColor: "#ffffff",
                                fontTransparency: 1.0,
                                cornerRadius: 20,
                                isSystemImage: false,
                                action:{
                                    if !selectedButton.isEmpty {
                                        selectedButton.removeLast()
                                    }
                                }
                            )
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing,screenWidth * (4/1376.0))

                    }
                }
                
                ZStack {
                    Rectangle()
                        .fill(Color.white.opacity(1.0))
                        .frame(width: screenWidth * (130/1376.0),height: screenHeight * (130/1032.0))
                        .cornerRadius(20)
                        .shadow(radius: 5,x: 3,y:4)
                    
                    CustomButton(
                        icon: "trash",
                        width: Int(screenWidth * (100/1376.0)),
                        height: Int(screenHeight * (100/1032.0)),
                        font: Int(screenWidth * (40/1376.0)),
                        iconWidth: Int(screenWidth * (50/1376.0)),
                        iconHeight: Int(screenHeight * (50/1032.0)),
                        bgColor: "#000000",
                        bgTransparency: 0,
                        fontColor: "#ffffff",
                        fontTransparency: 1.0,
                        cornerRadius: 20,
                        isSystemImage: false,
                        action:{
                            if !selectedButton.isEmpty {
                                selectedButton.removeAll()
                            }
                        }
                    )
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(.top,screenHeight * (110/1032.0))
            .padding(.bottom,screenHeight * (50/1032.0))
            
            
            HStack {
                CustomButton(
                    icon: "WarnaKuning",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
                CustomButton(
                    icon: "WarnaUngu",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
                CustomButton(
                    icon: "WarnaPink",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
                CustomButton(
                    icon: "WarnaHijau",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
                CustomButton(
                    icon: "WarnaHijau",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
                CustomButton(
                    icon: "WarnaBiru",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
                CustomButton(
                    icon: "WarnaOrange",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
                CustomButton(
                    icon: "WarnaAbu",
                    width: Int(screenWidth * (100/1376.0)),
                    height: Int(screenHeight * (50/1032.0)),
                    font: Int(screenWidth * (40/1376.0)),
                    iconWidth: Int(screenWidth * (100/1376.0)),
                    iconHeight: Int(screenHeight * (50/1032.0)),
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{

                    }
                )
                .padding(.trailing,screenWidth * (28/1376.0))
                
            }
            .padding(.trailing,screenWidth * (213/1376.0))
            
            // ScrollView for buttons
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(1.0))
                    .frame(width: screenWidth * (1370/1376.0),height: screenHeight * (800/1032.0))
                    .cornerRadius(40)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth * (120/1376.0)))], spacing: screenWidth * (10/1376.0)) {
                        ForEach(0..<columnsData.count, id: \.self) { columnIndex in
                            VStack(spacing: screenWidth * (10/1376.0)) {
                                // Determine the row limit for the current column
                                let rowLimit = (columnIndex == columnsData.count - 1) ? 9 : 6
                                
                                ForEach(0..<rowLimit, id: \.self) { rowIndex in
                                    if rowIndex < columnsData[columnIndex].count {
                                        let buttonData = columnsData[columnIndex][rowIndex]
                                        
                                        // Special design for the last column
                                        if columnIndex == columnsData.count - 1 {
                                            CustomButton(
                                                text: buttonData.0,
                                                width: Int(screenWidth * (100/1376.0)),
                                                height: Int(screenHeight * (60/1032.0)),
                                                font: Int(screenWidth * (18/1376.0)),
                                                iconWidth: Int(screenWidth * (50/1376.0)),
                                                iconHeight: Int(screenHeight * (50/1032.0)),
                                                bgColor: buttonData.1,
                                                bgTransparency: 1.0,
                                                fontColor: buttonData.2, // Use font color from buttonData
                                                fontTransparency: 1.0,
                                                cornerRadius: 15,
                                                isSystemImage: true,
                                                action: {
                                                    speakText(buttonData.0)
                                                    selectedButton.append(buttonData) // Append full data including icon
                                                }
                                            )
                                            .padding(.bottom,screenHeight * (3/1032.0))
                                        } else {
                                            // Default button for other columns
                                            CustomButton(
                                                icon: "person.fill", // Add icon from buttonData
                                                text: buttonData.0,
                                                width: Int(screenWidth * (100/1376.0)),
                                                height: Int(screenHeight * (100/1032.0)),
                                                font: Int(screenWidth * (16/1376.0)),
                                                iconWidth: Int(screenWidth * (40/1376.0)),
                                                iconHeight: Int(screenHeight * (40/1032.0)),
                                                bgColor: buttonData.1,
                                                bgTransparency: 1.0,
                                                fontColor: buttonData.2, // Use font color from buttonData
                                                fontTransparency: 1.0,
                                                cornerRadius: 10,
                                                isSystemImage: true,
                                                action: {
                                                    speakText(buttonData.0)
                                                    selectedButton.append(buttonData) // Append full data including icon
                                                }
                                            )
                                        }
                                    } else {
                                        Spacer()
                                            .frame(width: screenWidth * (100/1376.0), height: screenHeight * (100/1032.0))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, screenHeight * (40/1032.0))
                    .padding(.leading,screenWidth * (25/1376.0))
                }
                VStack{
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "#EEEEEE"))
                            .frame(width: screenWidth * (90/1376.0),height: screenHeight * (90/1032.0))
                            .cornerRadius(20)
                            .shadow(radius: 5,x: 3,y:4)
                        
                        CustomButton(
                            icon: "home",
                            width: Int(screenWidth * (50/1376.0)),
                            height: Int(screenHeight * (50/1032.0)),
                            font: Int(screenWidth * (40/1376.0)),
                            iconWidth: Int(screenWidth * (40/1376.0)),
                            iconHeight: Int(screenHeight * (40/1032.0)),
                            bgColor: "#000000",
                            bgTransparency: 0,
                            fontColor: "#ffffff",
                            fontTransparency: 1.0,
                            cornerRadius: 20,
                            isSystemImage: false,
                            action:{
                                
                            }
                        )
                        
                    }
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "#EEEEEE"))
                            .frame(width: screenWidth * (90/1376.0),height: screenHeight * (90/1032.0))
                            .cornerRadius(20)
                            .shadow(radius: 5,x: 3,y:4)
                        
                        CustomButton(
                            icon: "settings",
                            width: Int(screenWidth * (50/1376.0)),
                            height: Int(screenHeight * (50/1032.0)),
                            font: Int(screenWidth * (40/1376.0)),
                            iconWidth: Int(screenWidth * (40/1376.0)),
                            iconHeight: Int(screenHeight * (40/1032.0)),
                            bgColor: "#000000",
                            bgTransparency: 0,
                            fontColor: "#ffffff",
                            fontTransparency: 1.0,
                            cornerRadius: 20,
                            isSystemImage: false,
                            action:{
                                
                            }
                        )
                        
                    }
                }
                .padding(.leading,screenWidth * (1230/1376.0))
                .padding(.top,screenHeight * (380/1032.0))
                
            }
            
            .onAppear{
                print(UIScreen.main.bounds.width)
                print(UIScreen.main.bounds.height)
            }
            
        }
        .background(Color(hex: "#EEEEEE"))
    }
    
    
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }
    
    func speakAllText(from buttons: [(String, String, String)]) {
            // Concatenate all the strings from the tuples into a single text
            var fullText = ""
            for (text, warnaButton, warnaText) in buttons {
                fullText += "\(text) "
            }
            
            // Use the AVSpeechSynthesizer to speak the full text
            let utterance = AVSpeechUtterance(string: fullText)
            utterance.voice = AVSpeechSynthesisVoice(language: "id-ID") // Indonesian language
            utterance.rate = 0.5
            speechSynthesizer.speak(utterance)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AACRuangMakanView()
    }
}

