//
//  MainView.swift
//  Git-Challenges
//
//  Created by 권은빈 on 2022/01/15.
//

import SwiftUI

struct MainView: View {
    // ObservedObject of Challenge Card View
    @ObservedObject var githubService: GithubService = GithubService()
    @ObservedObject var colorThemeService: ColorThemeService = ColorThemeService()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                settings
                NameCardView()
                ChallengeCard()
                ContributionView()
                BadgeView()
                Spacer()
            }
            .onAppear(perform: {
                colorThemeService.getThemeColors()
                colorThemeService.getThemeEmojis()
            })
            .environmentObject(githubService)
            .environmentObject(colorThemeService)
            .modifier(NavigationBar())
        }
    }
    
    private var settings: some View {
        HStack {
            Spacer()
            refreshButton
            NavigationLink {
                SettingView()
            } label: {
                Image(systemName: "gear")
                    .foregroundColor(getThemeColors()[color.defaultGray.rawValue])
                    .font(.system(size: 20, weight: .bold))
            }
            .padding(.trailing, 20)
            .padding([.top, .bottom], 10)
        }
    }
    
    private var refreshButton: some View {
        Button {
            githubService.getCommitData()
        } label: {
            Image(systemName: "arrow.triangle.2.circlepath")
                .foregroundColor(getThemeColors()[color.defaultGray.rawValue])
                .font(.system(size: 20, weight: .bold))
        }
        .padding([.horizontal])
    }
}

struct NavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .ignoresSafeArea(.keyboard)
        }
        else {
            content
                .navigationBarHidden(true)
                .navigationBarTitle("")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}