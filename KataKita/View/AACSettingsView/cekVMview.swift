
//
//  cekVMview.swift
//  KataKita
//
//  Created by Aqilla Shahbani Mahazoya on 17/10/24.
//

import SwiftUI

struct cekVMview: View {
    @ObservedObject var viewModel: AACRuangMakanViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.cards.indices, id: \.self) { rowIndex in
                    ForEach(viewModel.cards[rowIndex]) { card in
                        VStack {
                            Image("\(card.icon)")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color(hex: card.category.fontColor, transparency: 1))
                            Text(card.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(hex: card.category.fontColor, transparency: 1))
                                .padding(5)
                                .background(Color(hex: card.category.color, transparency: 1))
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
