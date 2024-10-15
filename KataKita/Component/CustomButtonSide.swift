//
//  CustomButtonSide.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 09/10/24.
//

import SwiftUI

struct CustomButtonSide: View {
    let icon: String?
    let text: String?
    let font: Int
    let width: Int
    let height: Int
    let iconWidth: Int?
    let iconHeight: Int?
    let bgColor: String
    let bgTransparency: Double
    let fontColor: String
    let fontTransparency: Double
    let cornerRadius: CGFloat
    let strokeColor: String?
    let isSystemImage: Bool
    let action: (() -> Void)?
    
    init(icon: String? = nil, text: String? = nil, width: Int, height: Int, font: Int, iconWidth: Int? = nil, iconHeight: Int? = nil, bgColor: String, bgTransparency: Double, fontColor: String, fontTransparency: Double, cornerRadius: CGFloat,strokeColor: String? = nil, isSystemImage: Bool = true, action: (() -> Void)? = nil) {
        self.icon = icon
        self.text = text
        self.width = width
        self.height = height
        self.font = font
        self.iconWidth = iconWidth
        self.iconHeight = iconHeight
        self.bgColor = bgColor
        self.bgTransparency = bgTransparency
        self.fontColor = fontColor
        self.fontTransparency = fontTransparency
        self.cornerRadius = cornerRadius
        self.strokeColor = strokeColor
        self.isSystemImage = isSystemImage
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack(spacing: 4) {
                Spacer()
                if let text = text, !text.isEmpty {
                    
                    TextContent(
                        text: text,
                        size: Int(CGFloat(font)),
                        color: fontColor,
                        transparency: fontTransparency,
                        weight: "medium"
                    )
                    .padding(.trailing,8)

                }
                
                if let icon = icon, !icon.isEmpty {
                    if isSystemImage {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: CGFloat(iconWidth ?? 24), height: CGFloat(iconHeight ?? 24))
                            .foregroundColor(Color(hex: fontColor, transparency: fontTransparency))
                            .padding(.bottom,8)
                    } else {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: CGFloat(iconWidth ?? 24), height: CGFloat(iconHeight ?? 24))
                            .foregroundColor(Color(hex: fontColor, transparency: fontTransparency))
                            .padding(.bottom,8)
                    }
                }
                
                
                
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: CGFloat(width), height: CGFloat(height))
        .background(Color(hex: bgColor, transparency: bgTransparency))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
                    // Apply stroke only if strokeColor is provided
                    Group {
                        if let strokeColor = strokeColor {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(Color(hex: strokeColor, transparency: 1.0), lineWidth: 1)
                        } else {
                            EmptyView()
                        }
                    }
                )
        .shadow(color: Color(hex: "000000", transparency: 0.1), radius:10)
    }
}

// Text only
#Preview {
    CustomButtonSide(text: "Text Only", width: 150, height: 50, font: 14, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20)
}

// Icon only
#Preview {
    CustomButtonSide(icon: "star.fill", width: 100, height: 100, font: 50,iconWidth: 50, iconHeight: 50, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20)
}

// Image only
#Preview {
    CustomButtonSide(icon: "ball", width: 100, height: 100, font: 40, iconWidth: 50, iconHeight: 50, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20, isSystemImage: false)
}

// Icon and text
#Preview {
    CustomButtonSide(icon: "star.fill", text: "Star", width: 150, height: 50, font: 24, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20)
}

// Image and text
#Preview {
    CustomButtonSide(icon: "ball", text: "Custom", width: 153, height: 153, font: 24, iconWidth: 80, iconHeight: 60, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20, isSystemImage: false)
}

