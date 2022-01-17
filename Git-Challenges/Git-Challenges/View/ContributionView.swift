//
//  ContributionView.swift
//  Git-Challenges
//
//  Created by 강희영 on 2022/01/14.
//

import SwiftUI
import UIKit

func getThemeColors() -> [Color] {
    let colorPalette = ColorPalette()
    let themeColor: String = UserDefaults.standard.string(forKey: "ColorTheme") ?? "pink"
    UserDefaults.standard.setValue(themeColor, forKey: "ColorTheme")
    return colorPalette.getColors(themeColor)
}

func getThemeEmojis() -> [String] {
    let colorPalette = ColorPalette()
    let themeColor: String = UserDefaults.standard.string(forKey: "ColorTheme") ?? "pink"
    UserDefaults.standard.setValue(themeColor, forKey: "ColorTheme")
    return colorPalette.getEmoji(themeColor)
}



struct ContributionView: View {
    // MARK: Commits Data ViewModel
    @StateObject var vm = CommitViewModel()
    
    let weekday = Calendar.current.component(.weekday, from: Date())
    
    @ViewBuilder
    func ColorView(_ contributionLevel:Int) -> some View {
        let themeColors = getThemeColors()
        RoundedRectangle(cornerRadius: 2)
            .foregroundColor(themeColors[contributionLevel])
            .frame(width:15, height:15)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Contribution")
                    .font(.system(size: 18, weight: .bold))
                    .padding([.leading])
                Spacer()
            }
            ZStack {
                HStack(){}
                .frame(width:403, height:150)
                .modifier(CardModifier())
                ScrollView (.horizontal) {
                    HStack (spacing: 3) {
                        ForEach (0..<52, id: \.self) { col in
                            VStack (spacing: 3) {
                                ForEach (0..<7, id: \.self) { row in
                                    ColorView(vm.commits![col * 7 + row].level)
                                }
                            }
                        }
                        VStack (spacing: 3) {
                            ForEach(0..<weekday, id: \.self) {cell in
                                ColorView(vm.commits?[364 + cell].level ?? 0)
                            }
                            Spacer()
                        }
                    }
                    .cornerRadius(4)
                }
                .frame(width:353, height: 100)
                .padding()
                
            }
        }
    }
}

struct ContributionView_Previews: PreviewProvider {
    static var previews: some View {
        ContributionView()
    }
}
