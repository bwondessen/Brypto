//
//  BryptoApp.swift
//  Brypto
//
//  Created by Bruke on 6/8/22.
//

import SwiftUI
//import Firebase

@main
struct Brypto: App {
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init() {
//        FirebaseApp.configure()
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        //UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                //NavigationView {
                    MainView()
                        .navigationBarHidden(true)
                //}
                //.navigationViewStyle(.stack)
                .environmentObject(vm)
                
                ZStack {
//                    if showLaunchView {
//                        LaunchView(showLaunchView: $showLaunchView)
//                            .transition(.move(edge: .leading))
//                    }
                }
                .zIndex(2.0)
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .inactive:
                if vm.faceIDEnabled {
                    vm.isUnlocked = false
                    //vm.isLoggedIn = false
                }
            case .background:
                if vm.passcodeRequired {
                    vm.isLoggedIn = false
                }
            default:
                vm.isUnlocked = true
            }
        }
    }
}
