import SwiftUI

struct HomePageView: View {
    @State private var selectedOption: String = "Jadwal"
    @State private var shouldNavigate: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack {
                        CustomButton(
                            icon: "house", width: 100, height: 100, font: 50,
                            iconWidth: 50, iconHeight: 50, bgColor: "#EEEEEE",
                            bgTransparency: 1.0, fontColor: "#696767",
                            fontTransparency: 1.0, cornerRadius: 20
                        )
                        .padding(.bottom, 20)
                        
                        NavigationLink(destination: SettingsView()) {
                            CustomButton(
                                icon: "gear", width: 100, height: 100, font: 50,
                                iconWidth: 50, iconHeight: 50, bgColor: "#EEEEEE",
                                bgTransparency: 1.0, fontColor: "#696767",
                                fontTransparency: 1.0, cornerRadius: 20,
                                action: {
                                    selectedOption = "Setting"
                                    shouldNavigate = true
                                }
                            )
                        }
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    TextHeadline(text: "KanggoWicara", size: 60, color: "00000", transparency: 1.0, weight: "bold")
                        .padding(.trailing, 100)
                    
                    Spacer()
                }
                
                HStack {
                        CustomButton(
                            icon: "calendar", text: "JADWAL", width: 350, height: 350,
                            font: 40, iconWidth: 60, iconHeight: 60, bgColor: "#ffffff",
                            bgTransparency: 1.0, fontColor: "#555555",
                            fontTransparency: 1.0, cornerRadius: 20,
                            action: {
                                selectedOption = "Jadwal"
                                shouldNavigate = true
                            }
                        )
                        .padding(.trailing, 30)
                    
                        CustomButton(
                            icon: "keyboard", text: "AAC", width: 350, height: 350,
                            font: 40, iconWidth: 60, iconHeight: 60, bgColor: "#ffffff",
                            bgTransparency: 1.0, fontColor: "#555555",
                            fontTransparency: 1.0, cornerRadius: 20,
                            action: {
                                selectedOption = "AAC"
                                shouldNavigate = true
                            }
                        )
                        .padding(.leading, 30)
                    
                }
                
                Spacer()
            }
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            NavigationLink(
                destination: {
                    switch selectedOption {
                    case "Setting":
                        AnyView(SettingsView())
                    case "Jadwal":
                        AnyView(DailyActivityView())
                    case "AAC":
                        AnyView(AACRuangMakanView())
                    default:
                        AnyView(EmptyView())
                    }
                }(),
                isActive: $shouldNavigate,
                label: {
                    EmptyView()
                }
            )

        }
    }
}

#Preview {
    HomePageView()
}
