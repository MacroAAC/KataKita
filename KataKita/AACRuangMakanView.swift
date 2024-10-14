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
        [("saya", "#FFEBAF", "#000000"), ("kamu", "#FFEBAF", "#000000"), ("dia", "#FFEBAF", "#000000"), ("kita", "#FFEBAF", "#000000"), ("mama", "#FFEBAF", "#000000")],
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
    
    var body: some View {
        VStack(spacing:-13) {
            HStack {
                Button(action: {
                    speakAllText(from: selectedButton)
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 1190,height: 180)
                            .cornerRadius(10)
                            .padding(.leading,28)
                        
                        // HStack for displaying the selected buttons
                        HStack {
                            ForEach(selectedButton.indices, id: \.self) { index in
                                if index < 11 {
                                    // Display CustomButton for the first 11 items
                                    CustomButton(
                                        icon: "person.fill", // Use the new icon variable
                                        text: selectedButton[index].0, // Accessing the text from the tuple
                                        width: 100,
                                        height: 100,
                                        font: 16,
                                        iconWidth: 50,
                                        iconHeight: 50,
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
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 5)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 33)
                        .padding()
                        
                        HStack {
                            CustomButton(
                                icon: "delete",
                                width: 100,
                                height: 100,
                                font: 40,
                                iconWidth: 50,
                                iconHeight: 50,
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
                        .padding(.trailing,4)

                    }
                }
                
                ZStack {
                    Rectangle()
                        .fill(Color.white.opacity(1.0))
                        .frame(width: 130,height: 130)
                        .cornerRadius(20)
                        .shadow(radius: 5,x: 3,y:4)
                    
                    CustomButton(
                        icon: "trash",
                        width: 100,
                        height: 100,
                        font: 40,
                        iconWidth: 50,
                        iconHeight: 50,
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
            .padding(.top,50)
            .padding(.bottom,30)
            
            HStack {
                CustomButton(
                    icon: "WarnaKuning",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
                CustomButton(
                    icon: "WarnaUngu",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
                CustomButton(
                    icon: "WarnaPink",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
                CustomButton(
                    icon: "WarnaHijau",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
                CustomButton(
                    icon: "WarnaHijau",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
                CustomButton(
                    icon: "WarnaBiru",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
                CustomButton(
                    icon: "WarnaOrange",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
                CustomButton(
                    icon: "WarnaAbu",
                    width: 100,
                    height: 50,
                    font: 40,
                    iconWidth: 100,
                    iconHeight: 50,
                    bgColor: "#000000",
                    bgTransparency: 0,
                    fontColor: "#ffffff",
                    fontTransparency: 1.0,
                    cornerRadius: 0,
                    isSystemImage: false,
                    action:{
                        if !selectedButton.isEmpty {
                            selectedButton.removeAll()
                        }
                    }
                )
                .padding(.trailing,28)
                
            }
            .padding(.trailing,213)
            
            // ScrollView for buttons
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(1.0))
                    .frame(width: 1370,height: 800)
                    .cornerRadius(40)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 10) {
                        ForEach(0..<columnsData.count, id: \.self) { columnIndex in
                            VStack(spacing: 10) {
                                // Determine the row limit for the current column
                                let rowLimit = (columnIndex == columnsData.count - 1) ? 9 : 5
                                
                                ForEach(0..<rowLimit, id: \.self) { rowIndex in
                                    if rowIndex < columnsData[columnIndex].count {
                                        let buttonData = columnsData[columnIndex][rowIndex]
                                        
                                        // Special design for the last column
                                        if columnIndex == columnsData.count - 1 {
                                            CustomButton(
                                                text: buttonData.0,
                                                width: 100,
                                                height: 50,
                                                font: 18,
                                                iconWidth: 50,
                                                iconHeight: 50,
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
                                        } else {
                                            // Default button for other columns
                                            CustomButton(
                                                icon: "person.fill", // Add icon from buttonData
                                                text: buttonData.0,
                                                width: 100,
                                                height: 100,
                                                font: 16,
                                                iconWidth: 40,
                                                iconHeight: 40,
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
                                            .frame(width: 100, height: 100)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.leading,25)
                }
                VStack{
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "#EEEEEE"))
                            .frame(width: 130,height: 130)
                            .cornerRadius(20)
                            .shadow(radius: 5,x: 3,y:4)
                        
                        CustomButton(
                            icon: "home",
                            width: 60,
                            height: 60,
                            font: 40,
                            iconWidth: 50,
                            iconHeight: 50,
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
                            .frame(width: 130,height: 130)
                            .cornerRadius(20)
                            .shadow(radius: 5,x: 3,y:4)
                        
                        CustomButton(
                            icon: "settings",
                            width: 60,
                            height: 60,
                            font: 40,
                            iconWidth: 50,
                            iconHeight: 50,
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
                .padding(.leading,1230)
                .padding(.top,60)
                
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

