//
//  ActivitySequenceView.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 09/10/24.
//

import SwiftUI

struct ActivitySequenceView: View {
    var body: some View {
        let items = Array(1...10).map { "\($0)"}

        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 250))]) {
                ForEach(items, id: \.self) { item in
                    ActivityCard(icon: "ball", nomor: item, text: "Ambil sikat gigimu dan taru di dalam", width: 250, height: 150, font: 15, iconWidth: 50, iconHeight: 50, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20, isSystemImage: false)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                    
                }
                
                CustomButtonSide(icon: "hand.thumbsup.fill", text: "SELESAI", width: 125, height: 35, font: 15,iconWidth: 15 , iconHeight: 15, bgColor: "#000000", bgTransparency: 1.0, fontColor: "ffffff", fontTransparency: 1.0, cornerRadius: 20)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width-350)
            .background(Color.red)
            .cornerRadius(20) 

        }
    }
}

#Preview {
    ActivitySequenceView()
}
