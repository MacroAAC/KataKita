import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                HStack {
                    
                    Spacer()
                    
                    TextHeadline(text: "MAKKATA", size: 60, color: "00000", transparency: 1.0, weight: "bold")
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    CustomButton(
                        icon: "calendar", text: "JADWAL", width: 280, height: 280,
                        font: 40, iconWidth: 60, iconHeight: 60, bgColor: "#ffffff",
                        bgTransparency: 1.0, fontColor: "#555555",
                        fontTransparency: 1.0, cornerRadius: 20
                    )
                    .padding(.trailing, 30)
                    
                    CustomButton(
                        icon: "keyboard", text: "AAC", width: 280, height: 280,
                        font: 40, iconWidth: 60, iconHeight: 60, bgColor: "#ffffff",
                        bgTransparency: 1.0, fontColor: "#555555",
                        fontTransparency: 1.0, cornerRadius: 20
                    )
                    .padding(.leading, 30)
                }
                
                Spacer()
                
                NavigationLink(destination: SettingsView()) {
                    CustomButton(
                        icon: "settings", width: 80, height: 80, font: 50,
                        iconWidth: 35, iconHeight: 35, bgColor: "#ffffff",
                        bgTransparency: 1.0, fontColor: "#696767",
                        fontTransparency: 1.0, cornerRadius: 20, isSystemImage: false
                    )
                }
                
                Spacer()
            }
            .background(Image("homeBackground"))
        }
    }
}

#Preview {
    HomePageView()
}



