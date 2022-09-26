//
//  MainView.swift
//  Brypto
//
//  Created by Bruke on 8/31/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedTab = "HomeView"
    @State private var inPortfolioTab = true
    
    var body: some View {
        if vm.isSignedUp && vm.isLoggedIn && vm.faceIDEnabled {
            if !vm.isUnlocked {
                faceIDScreen
            } else {
                mainView
            }
        } else if vm.isSignedUp && vm.isLoggedIn && !vm.faceIDEnabled {
            mainView
        } else if vm.isSignedUp && !vm.isLoggedIn {
            NavigationView {
                LoginView()
            }
        } else {
            SignUpView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    var mainView: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag("HomeView")
            
            CryptoNewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                }
                .tag("CryptoNewsView")
            
            PortfolioView(inPortfolioTab: .constant(true))
                .tabItem {
                    Image(systemName: "person")
                }
                .tag("PortfolioView")
                .navigationViewStyle(.stack)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
                .tag("SettingsView")
            
        }
     }
    
    var faceIDScreen: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
        }
        .onAppear(perform: vm.authenticate)
    }
}

