//
//  ActivitySequenceView.swift
//  KataKita
//
//  Created by Gwynneth Isviandhy on 09/10/24.
//

import SwiftUI

struct ActivitySequenceView: View {
    var body: some View {
        let items = Array(0...50).map { "\($0)"}

        VStack {
            ScrollView {
                  LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))]) {
                    ForEach(items, id: \.self) { item in
                        ActivityCard(icon: "ball", nomor: "1", text: "Ambil sikat gigimu dan taru di dalam", width: 160, height: 100, font: 12, iconWidth: 50, iconHeight: 50, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20, isSystemImage: false)
                        .padding(16)
                        .frame(maxWidth: .infinity)

                    }
                      
                      CustomButton(icon: "hand.thumbsup.fill", text: "DONE", width: 150, height: 50, font: 24, bgColor: "#000000", bgTransparency: 1.0, fontColor: "#ffffff", fontTransparency: 1.0, cornerRadius: 20)
                      
                  }.padding()
                }
        }
    }
}

#Preview {
    ActivitySequenceView()
}
