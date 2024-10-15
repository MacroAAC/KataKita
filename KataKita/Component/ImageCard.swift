//
//  CustomButton.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 09/10/24.
//
import SwiftUI

struct ImageCard: View {
    let image: UIImage?
    let width: Int
    let height: Int
    let icon: String?
    let font: Int
    let iconWidth: Int?
    let iconHeight: Int?
    let bgColor: String
    let bgTransparency: Double
    let fontColor: String
    let fontTransparency: Double
    let cornerRadius: CGFloat
    let isSystemImage: Bool
    let action: (() -> Void)?

    init(image: UIImage? = nil, icon: String? = nil, width: Int, height: Int, font: Int, iconWidth: Int? = nil, iconHeight: Int? = nil, bgColor: String, bgTransparency: Double, fontColor: String, fontTransparency: Double, cornerRadius: CGFloat, isSystemImage: Bool = true, action: (() -> Void)? = nil) {
        self.image = image
        self.icon = icon
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
        self.isSystemImage = isSystemImage
        self.action = action
    }

    var body: some View {
        VStack(spacing: 4) {
            Spacer()
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: CGFloat(iconWidth ?? 24), height: CGFloat(iconHeight ?? 24))
                    .padding(.bottom, 8)
            } else if let icon = icon, !icon.isEmpty {
                if isSystemImage {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: CGFloat(iconWidth ?? 24), height: CGFloat(iconHeight ?? 24))
                        .foregroundColor(Color(hex: fontColor, transparency: fontTransparency))
                        .padding(.bottom, 8)
                } else {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: CGFloat(iconWidth ?? 24), height: CGFloat(iconHeight ?? 24))
                        .foregroundColor(Color(hex: fontColor, transparency: fontTransparency))
                        .padding(.bottom, 8)
                }
            }
            Spacer()
        }
        .frame(width: CGFloat(width), height: CGFloat(height))
        .background(Color(hex: bgColor, transparency: bgTransparency))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(radius: 10)
    }
}




// Image only
#Preview {
    ImageCard(icon: "ball", width: 100, height: 100, font: 40, iconWidth: 50, iconHeight: 50, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20, isSystemImage: false)
}
