//
//  AddAACModalSheets.swift
//  KataKita
//
//  Created by Aqilla Shahbani Mahazoya on 10/10/24.
//

import SwiftUI

struct AddAACModalSheets: View {
    @Binding var isPresented: Bool
    @State private var textToSpeak: String = ""
    
    var onCancel: () -> Void
    var onDone: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                // TextField for "Text to Speak"
                TextField("Text to Speak", text: $textToSpeak)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Add Image option
                HStack {
                    Text("Add Image")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarTitle("Add Button", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                onCancel()
                isPresented = false
            }, trailing: Button("Done") {
                onDone(textToSpeak)
                isPresented = false
            })
        }
    }
}

#Preview {
    AddAACModalSheets(isPresented: .constant(true), onCancel: {}, onDone: { _ in })
}
