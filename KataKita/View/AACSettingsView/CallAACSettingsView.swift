//
//  CallAACSettingsView.swift
//  KataKita
//
//  Created by Aqilla Shahbani Mahazoya on 15/10/24.
//

import SwiftUI

struct CallAACSettingsView: View {
    @State private var showAACSettings = false
    @ObservedObject var viewModel = CardViewModel()
    
    @State static var navigateTooAddImage = true
    @State static var selectedSymbolImage = "star.fill"
    @State static var navigateFromSymbols = false
    @State static var navigateFromImage = false
    @State static var selectedSymbolName = ""
    @State static var textToSpeak = ""
    
    var body: some View {
        Button("Choose Image...") {
            showAACSettings = true
        }
        .sheet(isPresented: $showAACSettings) {
            AddButtonAACView(
                textToSpeak: CallAACSettingsView.$textToSpeak, navigateTooAddImage: CallAACSettingsView.$navigateTooAddImage,
                navigateFromSymbols: CallAACSettingsView.$navigateFromSymbols,
                navigateFromImage: CallAACSettingsView.$navigateFromImage,
                selectedImageName: CallAACSettingsView.$selectedSymbolName,
                selectedImage: .constant(nil), cardViewModel: viewModel
            )
        }
    }
}

#Preview {
    CallAACSettingsView()
}
