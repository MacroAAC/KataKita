//
//  CustomActivityCard.swift
//  KataKita
//
//  Created by Alvito Dwi Reza on 13/10/24.
//

import SwiftUI

struct SettingActivityCard: View {
    let activity: Activity
    let number: Int?
    let delete: (() -> Void)?
    init(_ activity: Activity, number: Int? = nil, delete: (() -> Void)? = nil) {
        self.activity = activity
        self.number = number
        self.delete = delete
    }
    var body: some View {
        HStack (spacing: 20){
            if let number {
                Circle()
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 25, height: 25)
                    .overlay(
                        Text("\(number)")
                    )
            }
            HStack{
                if let image = activity.image {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(width: 60, height: 60)
                        .overlay(Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                        )
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(width: 60, height: 60)
                        .overlay(Image(systemName: "crossmark")
                            .resizable()
                            .frame(width: 30, height: 30)
                        )
                }
                
                Text("\(activity.name)")
                
            }
            Spacer()
            if(number != nil) {
                Button {
                    if let delete {
                        delete()
                    }
                } label: {
                    Circle()
                        .fill(.red)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Image(systemName: "minus").foregroundStyle(.white)
                        )
                }
                    
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            VStack {
                Spacer()
                Rectangle()
                    .fill(.tertiary)
                    .frame(height: 1)
                
            }
        )
    }
}


